#encoding:utf-8

# 01 配置系统自动选择的python版本  
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2
update-alternatives --list python
update-alternatives --config python

# 02 后台运行命令
python aa.py > out.file 2>&1 &      # n>&m, 是将输出文件m和n合并, n,m是文件描述符
nohup python aa.py > out.file 2>&1 &    # 退出shell终端时继续执行命令
# ps: stdin, stdout, stderr描述符分别是:0, 1, 2
# ps: cmd > file, cmd < file是一个简写, 实际上是cmd 1>file, cmd 0<file, 所以要将
#     stderr重定向到file是cmd 2>file; cmd >file 2>&1, 是将stdout和stderr合并后重定向到file
#     ps: 文件描述符和>之间不能有空格, 而file和>则可以有空格, 所以最好是都不写空格

# 03 计算哈希值
md5sum filename
sha1sum filename

# 04 下载命令
wget option url
-b 后台下载
-c 继续下载
-P 指定保存的路径
--http-user   指定用户名
--http-passwd 指定密码
# 下载情感识别数据集:RECOLA的用户名和密码
# wget -c --http-user Zhiyong_Wu --http-passwd 'd$r,162V}3{;[&&g' https://diuf.unifr.ch/main/diva/recola/data/corpus/recola/AVEC_2018_GES/recordings_audio.zip

# 05 查看端口命令
netstat -ap | grep process_name # 查看进程对应的的端口号,ap前面必须有-
lsof -i:port_num    # 查看该端口对应的pid和程序名
ss -lptu    #类似于netstat,但是此命令会显示进程名

# 06 进入applications目录
nautilus /usr/share/applications    # nautilus被卸载了
nemo /usr/share/applications        # 用nemo代替了

# 07 调节屏幕亮度
sudo setpci -s 00:02.0 F4.B=FF # [00, FF], 00:02.0 是屏幕设备的地址
lspci | grep -i vga  # 查看屏幕设备

# 08 查看磁盘使用情况
df -h   # 查看整个磁盘的使用情况
df -h /usr  # 查看分区/usr的使用情况,如果/usr不是单独分区的,则结果是/分区的使用情况
    # df -h your_dir命令中,your_dir必须是单独分区的,其实此命令就是显示df -h的某一行
du --max-depth=1 -h /usr    # 查看目录/usr的使用情况,此条命令可以查看usr的实际使用量
du --max-depth=1 -h /       # 查看根目录下所有子目录的使用情况
    # df是查看指定分区的使用情况,如果给的是目录,则是该目录所在分区的使用情况
    # du是查看指定目录的使用情况
du -sh /usr # 计算/usr目录的占用空间大小,结果和du --max-depth=1 -h结果的最后一行是一样的
df -h / # 查看根分区占用大小,/下单独分区的目录不算在内的,如/home, /boot
df -h /home # 查看/home分区大小
df -h /boot # 查看/boot分区大小
du -sh /usr # 查看/usr目录占用大小
du -sh /usr/bin # 查看/usr/bin目录占用大小
du -sh /home    #效果与df -h /home一样的

# 09 弹出u盘
df -a   # 查看U盘是在/dev/的哪个目录下,如/dev/sda1
sudo eject /dev/sda1    # 弹出u盘

# 10 查看可用的显卡驱动程序
# 直接从update软件中下载也很快的,前提是把网络设置好了
sudo add-apt-repository ppa:graphics-drivers/ppa    # 安装nvidia的apt源
sudo apt update
ubuntu-drivers devices  # 查看只要这条命令即可
nvidia-settings  # 打开设置窗口,在Prime Profiles中可以配置使用inter集显还是nvidia独显
nvidia-smi       # 查看显卡使用情况 
sudo apt autoremove --purge nvidia* # 删除显卡驱动程序和管理程序
lspci -vnn | grep -i VGA -A 12 # 查看系统中安装好的显卡(显卡驱动程序)
lspci -k | grep -A 2 -i "VGA"  # 同上

# 11 解决apt出现无法获得锁的错误
# 方法一
ps -aux | grep apt  # 查看目前正在占有apt锁的进程pid, 或者是ps aux 无-
sudo kill pid       # 杀死该进程即可
# 方法二
ps -e | grep apt    # -e选项显示pid和进程名
sudo killall apt    # 知道完整命令名后用killall删除, killall 可以杀死指定名称的进程

# 12 指定忽略某个软件的更新
apt-mark hold xxx   # 在apt upgrade时,xxx不会被更新了
apt-mark unhold xxx # 解除hold,使得xxx可以更新
dpkg --get-selections xxx # 查看xxx的锁定状态:hold是锁定,install是没有锁定

# 13 pip指定安装源
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy -U    # 从指定源安装最新版本的numpy
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple #　指定默认源,此命令会写pip.conf文件

# 14 ipconfig /rlease /renew 的ubuntu版本
sudo dhclient -r    # 重新获得ip地址并关闭dhcp client,此命令执行后将无法上网
sudo dhclinet       # 重新开启dhcp client,执行完此命令后才能上网
sudo dhclient -x    # 关闭dhcp client,但是不释放ip地址

# 15 修改ubuntu登录界面
cd /etc/alternatives/   # 进入配置目录
ls -lh | grep gdm3.css  # 查看gdm3.css这个链接文件指向的真实文件
cd /usr/share/gnome-shell/theme/Yaru/ # gdm3.css目前指向gnome-shell.css
cp gnome-shell.css gnome-shell.bak    # 备份一下这个文件
vim gnome-shell.css     # 找到lockDialogGroup,修改成现在的内容即可
# 注: 前面几步均已配置好,现在如果要修改登录界面,只需最后一步中将file:///后的文件地址修改即可
# 具体可以看这个网址https://zhuanlan.zhihu.com/p/36470249

# 16 设置点击dock图标,最小化应用
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# 17 打开ubuntu软件中心
gnome-software %U

# 18 为文件创建link(硬链接和软链接均可创建)
# 硬链接也保存了i-node信息的,都指向相同的文件内容,它和原来的文件地位等同,只是路径和名字不同
#   删除某一个文件后,只要指向i-node的文件数目>=1,则文件不会删除
# 软链接它本身是一个文件,这个文件的内容是它指向目标文件的绝对文件名,可以对软链接文件进行编辑
#   此时同样会修改它指向的目标文件,但是如果目标文件修改了名字或者移动到其他目录下了,则该软链
#   接将会失效,因为它的文件内容中存放的文件名已经找不到源文件了,硬链接不会有这个问题
# 总结: 硬链接存放的是i-node信息,软链接存放的是源文件的绝对路径

# ln TARGET LINK_NAME   # TARGET是源文件,LINK_NAME是硬链接文件名
ln cc.cpp GG    # 为cc.cpp创建硬链接,名字为GG,此时GG和cc.cpp在同一目录下
ln cc.cpp tf/GG # 此时GG在tf目录下,如果tf/aa/目录不存在的话,则ln cc.cpp tf/aa/GG非法
ln ~/cc.cpp     # 此用法是cc.cpp不能在当前目录下,ln在当前目录下创建一个同名的硬链接cc.cpp

ln cc.cpp cmd.sh killpid.sh tf/ # 为多个文件创建硬链接,此时最后一个参数是一个目录
ln -t tf cc.cpp cmd.sh killpid.sh  # 和上一条命令等价
ln -s cc.cpp GG # 加-s选项,则是创建软链接(symbolic link),一般用于链接可执行程序
# ps: 使用-f选项, 可以直接覆盖同名的文件
# ps: 软连接其实是很有用的, 因为scp, cp或修改其实都是对原来的实体文件(目录)进行的, 还可以跨文件系统
# ps: ls -lhi, 可以查看文件的inode编号, 另外, ls -lh 中文件权限后的那一列的数字是文件的硬链接数目
# ps: 对于那些名字一般不会变的文件(配置文件等), 最好是用软连接, 因为可以知道它链接到哪里了, 如果
#     用硬链接的话, 则是不知道它和哪些文件关联的

# 19 打开utorrent
utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
# 浏览器访问地址: 127.0.0.1:8080/gui

# 20桌面图标最小化
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# 21 ppa和升级软件
sudo add-apt-repository ppa:user/ppa-name    # 添加ppa
sudo add-apt-repository -r ppa:user/ppa-name # 删除ppa
sudo apt update
sudo apt list --upgradable -a     # 查看可更新的软件以及版本号
sudo upgrade package-name=ver-num # 根据刚才的版本号,或者需要的版本号升级该软件
# 如果不知道ppa:user/ppa-name了, 则可以直接查看/etc/apt/sources.list.d/下该ppa的.list和.save文件
# 找到后直接删除即可, 这是因为ppa的源的添加实际上是在sources.list.d下创建了list文件
# https://zhuanlan.zhihu.com/p/55250294

# 22 转换音频格式
avconv -i xx.m4a -ar 22050 xx.wav
# 源码安装libav, 网上的教程sudo apt install libav-tools行不通, ubuntu上没有该源
git clone git://git.libav.org/libav.git # 下载有点慢,可以直接上github网站上下载
cd libav    # 网上下载的压缩包需要先解压,然后进入目录, https://github.com/libav/
./configure # 如果出现没有nasm, yasm的错误,就sudo apt update && sudo apt nasm yasm
make
make install

# 23 update grub
sudo update-grub
sudo grub-install /dev/nvme0n1	# 因为我的ubuntu安装在nvme0n1盘上

# 24 系统配置
## 00 显卡配置
# 先禁用NVIDIA驱动: 在grub中进入recovery模式,然后将"ro"后面的都删掉,改成ro quiet splash nouveau.modeset=0,再按f10进入系统
# 安装NVIDIA驱动:
sudo add-apt-repository ppa:graphics-drives/ppa
sudo apt update
sudo apt install nvidia-390
reboot  # 重启后可能没有nvidia-settings,需要再手动安装一下

## 01 pip ipython trash-cli的安装
# pip,ipython,flake8,pyflakes,trash-cli等的安装基本上都一样,因为它们的模式都是一个python库+一个调用该库的python可执行程序,
# 都是需要先用apt安装该命令,然后再用pip升级该库,或者自己手动安装该库

# pip安装
sudo apt install python3-pip        # 先用apt安装一个较旧的pip版本
pip3 install -U pip		# 将pip升级到最新版本,此时使用pip会出现找不到main模块的错误,这是因为老版本的pip执行程序不兼容新版本
sudo vim /usr/bin/pip3	# 修改pip3文件,可以直接copy我备份的pip文件,或者参考我的博客,同样的方法可以安装pip2: python-pip
sudo cp pip3 pip		# 创建pip文件,把第一行的python3改成python
sudo apt remove --purge python3-pip	# 安装好后删除旧版本
# ps: 在升级完pip后,会在~/.local/bin下生成pip的可执行文件,但是可能这个目录又不在PATH中,所以需要好动将之加入到PATH中,我是在
#   bashrc中加入的, 对于flake8,pyflakes,ipython等这些用pip安装后也是在这个目录下生成可执行文件的
# ps: 安装python-pip后,可能会由于系统默认的python时python3,导致pip2这个程序执行失败,此时将pip2第一行改成python2或者将系统默认
#   pythhon改成python2,然后在pip2 install -U pip对pip2进行更新,注意,之后可以删掉python-pip,但是会导致python2也被删掉的,所以还
#   需要手动安装一下python2
# ps: 最后最好将.local/bin下的可执行文件复制到/usr/bin下,因为有可能需要用sudo执行这些文件,如果不放的话,sudo会找不到的,比如用
#   pip安装shadowsocks时,由于需要用sudo pip安装,所以pip必须放在/usr/bin下

# ipython安装
pip install --user ipython	# 安装ipython的库, 将备份的ipytho文件copy到/usr/bin/即可(也可用apt安装下ipython可自动获得ipython文件)

# trash-cli安装
sudo apt install trash-cli	# 如果系统默认用python2的话,则已经可用了
# python3需要源码安装
git clone https://github.com/andreafrancia/trash-cli.git
cd trash-cli
python setup.py install --user
# 需要注意的是, 此时系统中有两份trash-cli,一份在/usr/bin下,是由apt安装的,另一份在.local/bin下,是python3安装的,这两组命令的接口
# 还不太一样,apt中的是restore-trash,而.local/bin下的是trash-restore,所以我直接把apt安装的trash-cli卸载了,保持以前的习惯
# ps: 最简单的方式,就是先把我的trash-cli备份文件夹copy过来,然后执行python setup.py install --user即可

## 02 vim配置
mkdir -p ~/.vim/bundle
cp /path/to/vimrc.bak ~/.vimrc # 将备份的vimrc文件放在~目录下
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim # 我直接备份了该文件夹,下次直接copy就行
vim +PluginInstal +qall # 安装vimrc中的插件, 也可以先打开vim,然后再PluginInstall
# ps: git命令是用于安装Vundle的,也就是说只要把插件放在了bundle目录下,就算安装了该插件了
# 经过上面的操作,所有插件都可以用了,但是语法检查插件还不能正常工作,因为还没有pyflake8,pyflakes,pylint
pip instal flake8       # 安装flake8
pip install pyflakes    # 安装pyflakes
pip install pylint      # 安装pylint, 其实只要安装了flake8即可,因为vimrc文件中只允许使用flake8
# ps: 上面的三个命令会直接被安装在.local/bin中,因为我本地的PATH中包含了.local/bin,所以可以直接运
# 行这三个命令,而在服务器上因为.local/bin没有被添加在PATH中,就不能直接使用,此时vim的syntastic也就
# 不能正确使用这个三个命令来检查语法,所以在服务器上,可以把这三个执行文件放在~/.bin目录下即可
# 本地也可以用apt来安装它们

## 03 shadowsocks配置
sudo pip install shadowsocks    # 此处必须用sudo安装,此时sslocal命令被放在/usr/local/bin/下
sudo vim /usr/local/lib/python3.6/dist-packages/shadowsocks/crypto/openssl.py
#:%s/cleanup/reset/gc           # 将cleanup替换成reset即可,一共有两处再52和111行
# pip安装shadowsocks时,最好是用sudo安装,因为sslocal这条命令需要sudo权限,如果安装在~/.local/bin下
# 的话,则sudo是找不到该命令的
# 配置好后,需要先开启系统手动代理,设置socks为127.0.0.1, 1080
# 然后打开chrome登录同步,等扩展程序都同步过来后,打开switchy-omega扩展程序,导入备份中的switchy-omega.bak文件即可

# 安装shadowsocks-qt5
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt update
sudo vim /etc/apt/sources.list.d/hzwhuang-ubuntu-ss-qt5-comsic.list # 将comsic改成xenial
sudo apt update  # 因为18.04以及以上版本没有shadowsocks-qt5源, 所以只能改成16.04的
sudo apt install shadowsocks-qt5
sudo ss-qt5  # 启动ss-qt5

## 04 修改登录界面
sudo nautilus /usr/share/backgrounds    # 打开系统壁纸文件夹
# 选择一张喜欢的,给它重命名一下,然后在tweak里边设置即可
sudo vim /etc/alternatives/gdm3.css # 将lockDialogGroup修改成下面的内容即可,图片选喜欢的
'''
#lockDialogGroup {
  background: #2c001e url(file:///usr/share/backgrounds/zm01.jpg);         
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center; }
'''

## 05 其他软件
sudo apt install workrave  # 可以使用添加ppa源的方式安装最新版本, 并且支持下载workrave-gnome, 更改source.list.d中的文件名即可
sudo apt install goldendict   # 有道网址: http://dict.youdao.com/search?q=%GDWORD%&ue=utf8
sudo apt install okular
sudo apt install chrome-gnome-shell # 安装chrome的gnome-shell扩展,没有此程序,则chrome的gnome-shell扩展程序没法用
sudo apt install redshift    # 设置屏幕色温的软件, 需要有一个配置文件~/.config/redshift.conf
    # 如果出现geoclue no location的错误, 则可以先在设置->私有中开启位置, 然后运行redshift, 会显示经(E, lontitude)纬(N, latitude)度, 
    # 然后可以把经纬度在配置文件中写好, 然后在关掉打开位置的设置

## 06 一些设置
sudo apt-mark hold fcitx nautilus   # 保持nautilus和fcitx不要更新
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' # 设置单击为最小化图标
sudo apt install gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 gir1.2-clutter-1.0 # 对system-monitor安装后缺少的库进行安装
ssh-keygen      # 生成rsa密钥对, 存放公钥的文件时authorized_keys

## 07 系统备份
tar -cvpzf /media/caixiong/caixiong/ubuntu_backup_20190501.tar.gz --exclude=/proc --exclude=/tmp --exclude=/lost+found --exclude=/media --exclude=/mnt --exclude=/run --exclude=/boot --exclude=/home /
tar -cvpzf /media/caixiong/caixiong/home_backup_20190501.tar.gz /home
tar -cvpzf /media/caixiong/caixiong/boot_backup_20190501.tar.gz /boot
# 由于备份/时排除了一些目录,所以如果是想先删除/再恢复的话,需要把这些目录再创建进来,包括/home和/boot的恢复
# 如果恢复前不删除/,则tar只是会将压缩文件中已经有的目录替换/下的相同目录,而不会删除压缩文件中没有的目录
# 参考文献: https://blog.csdn.net/qq_35523593/article/details/78545530

# 25 python相关
## 01 安装pyaudio库
sudo apt install python3-pyaudio  # 用pip安装会出错的
sudo pacman -S python3-pyaudio    # 在服务器上安装, 服务器上只有pacman可以用sudo权限
passwd cai-x18  # 修改登录密码, 不用sudo权限也可以修改的

## 02 awk过滤loss, 计算时间平均值
awk '/ Step /{print $4, $5, $7, $8}' Terminal_out30 | awk -F ',' '{print $1, $2}' | awk -F ']' '{print $1}' | awk -F '[' '{print $1, $2}' > out30.log
awk '{if(NR>=200000){sum += $2}} END{print sum/(NR-200000)}' layers11.log

## 03 ImportError: No module named  tkinter
sudo apt-get install python3-tk

## 04 安装强制对齐工具:aeneas
# 先下载处理依赖的sh文件
wget https://raw.githubusercontent.com/readbeyond/aeneas/master/install_dependencies.sh
chmod + x install_dependencies.sh
./intall_depencies.sh
pip install aeneas --user   # 如果不先安装依赖的话, 此处会出错

# 网址: https://pypi.org/project/aeneas/1.4.0.0/#linux

# 26 baidu百度云下载
## 01
cd ~/tmp/webui-aria2/
node node-server.js &  # 打开aria2c的web-ui界面, 需要在浏览器访问localhost:8888
sudo aria2c --conf-path=/home/caixiong/.config/aria2c.conf  # 打开aria2c下载服务端口
# 下一步是登录百度云网页, 然后选择需要下载的文件, 然后点击导出下载, 选择aria-rpc即可, 导出下载时baidu-exporter插件提供的
# 如果出现下载错误, 很有可能是因为没有保存而直接下载的, 需要先保存, 然后在下载 

## 02 直接执行bnd命令即可, 可能需要先登录百度云, 然后复制BDUSS(crl+shift+c, 点击applications可找到)
bnd         # 下载地址:https://github.com/b3log/baidu-netdisk-downloaderx/releases/download/v20190715/BND1-v4.0.0-linux.zip

## 03 使用百度网盘助手: https://www.runningcheese.com/go?url=https://www.baiduyun.wiki/
# 快速使用的方法: 打开这个网址即可生成下载链接: https://pan.baidusu.com/
# 下载和安装相应插件

# 27 wps无法登录和符号缺失问题
# 无法登录
cd /proc
tree -af . | grep -i kingsoft  # 找到包含kingsoft的文件夹(是一个数字命名的)
sudo rm -r the_finded_dir  # 如果出现权限错误, 就killp wps && killp wpp把wps和wpp程序全部关闭
# 符号缺失, 因为之前无法登录, 我重新装了一下wps, 导致之前的字体和符号文件没了
sudo mkdir /usr/share/fonts/wps-office
sudo cp ~/apps/wps/wps_symbol_fonts.zip /usr/share/fonts/wps-office
cd /usr/share/fonts/wps-office
unzip wps-office  # ok, 此时还是有字体缺失了

# 28 unix和win文件转换
# 如果文件中显示的是, 则在vim中输入:%s//\r/g即可, 注意是按ctl+v和ctl+m, 而不是^M两个字符, ctl+M是回车键
# 用工具: dos2unix和unix2dos, 但是这两个工具似乎没什么效果

# 29 分别设置目录和文件的权限
chmod 755 `find . -type d`  # 对当前目录下的所有目录设置755权限
chmod 444 `find . -type f`  # 对当前目录下的所有文件设置444权限

# 30 查看系统版本
lsb_release -a     # 适用于遵守LSB规范的linux: RedHat, SuSE, Debian, Ubuntu, Centos等
cat /etc/issue     # 可以查看arch linux的版本
cat /etc/os-releases

# 31 查看cpu信息
lscpu               # 可以查看cpu数(physical id), 物理核数(core id), 逻辑核数(processor), porcessor=cpu个数*物理核数*每核的线程数
cat /proc/cpuinfo   # 查看各个processor的具体信息: core是酷睿(i)系列, xeon是(e)系列(服务器用)
cat /proc/cpuinfo | grep "physical id" | uniq # 查看cpu个数
cat /proc/cpuinfo | grep "core id" | uniq     # 查看每个cpu的物理核数
cat /proc/cpuinfo | grep "processor" | wc -l  # 查看逻辑核数, 逻辑核是同一时刻cpu可以并行处理的任务数

# 32 登录openvpn
sudo openvpn --config /etc/openvpn/client.ovpn

# 33 清理内存
ps aux | sort -nrk 4| head -n 5     # 查看占用率最高的5个进程, 第1 2 3 4列分别是:用户, pid, cpu, 内存, 最后1列是命令
kill pid        # 根据后面的命令名, 将不需要的进程关掉

free -m		# 显示内存分配情况, 如果发现buff/cache这一项很大的话,执行下面的命令
sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'	# echo后的1可以改成2,3

# 33 tensorboard远程
ssh -L 16006:127.0.0.1:6006 cai-x18@219.223.184.103
tensorboard --logdir your_log_dir -port 6006    # 在远程服务器上执行
# 本地浏览器打开localhost:16006     # 新的端口好像必须是16006, 之前使用6666不行

# 34 输出随机数
echo $RANDOM    # 系统变量RANDOM的值在[0, 32767]之间

## 使用date命令, 但是这样生成的数字会比较大
date +%s%N      # 以一个长数字获得当前的时间
date +%s%N | cksum | awk '{print $1}' # cksum是计算循环校验码, 返回一个32位的int数
$(($(date +%s%N) % 2 ** 32))
let "a=$(date +%s%N) % 2 ** 32"

cat /dev/urandom | head -n 20 | cksum | awk '{print $1}'    # 不会阻塞, 但是数字也比较大

cat /proc/sys/kernel/random/uuid | cksum | awk '{print $1}' # uuid是一个长度为32的16进制数
# ps: 将cksum改成md5sum, 就可以生成随机字符串了, 如 date +%s%N | md5sum | head -c 10

# 35 大小写转换
echo "hello" | tr 'a-z' 'A-Z'
echo "HELLO" | tr 'A-Z' 'a-z'

# 36 vim记录模式(宏)
# shs step118:111111114 hellohellohellohellonormal模式下按q + 宏名 开始录制, 注意宏名只能是一个字母, 接下来的所有按键都会被记录下来
# step2: 进行编辑, 此时可以是任意模式下的任意按键, 所有按键都会被记录下来
# step3: normal模式下按q结束录制
# step4: normal模式下, 按下@ + 宏名就可以执行宏了, 如果可以先按一个数字, 表示执行宏多次

# ps: 宏录制完成后, 在文件关闭又重新打开后仍然是可以使用的
# ps: ctrl + a 可以给光标后面的第一个数字加1(normal模式下), 如果光标在一个数字上, 则给这个数字加1
#       ctrl + x则是减1, 如果在插入模式下按ctrl + a和ctrl +x则是另外的命令, 具体也没搞懂
# ps: ctrl + s 后vim会假死, 其实此时只是进行的任何操作不在屏模式显示了, 实际上你的操作是都进行了的
#       此时按下ctrl + q即可恢复正常

# 36 man + 数字用法
1 - commands
2 - system calls
3 - library calls
4 - special files
5 - file formats and convertions
6 - games for linux
7 - macro packages and conventions
8 - system management commands
9 - 其他
man 5 sources.list  # 查看sources.list等文件说明
# 这是因为man手册分为多个section, 数字代表section的编号

# 37 apt命令使用
sudo apt update     # 更新包数据库, 我猜apt会根据sources.list和sources.list.d中的软件仓库源, 把它们里边
    # 的包的版本信息等写入本地数据库, update则是更新这个本地数据库的, 之后apt是根据本地数据库去安装包的
    # 所以要先update然后再安装, Hit是没有改动, Get是此源对包数据库进行更新,Ign是忽略
sudo apt upgrade    # 升级所有可更新的包, 这个是真正安装包, 一般要先运行apt update
sudo apt full-upgrade   # 如果当前更新的包需要删除之前已经安装的包, 则此命令会这样做, 而upgrade则不会升级
sudo apt install pkg1_name pkg2_name pkg3_name --no-upgrade  # no-upgrade是说如果已经安装了, 即使有
    # 新版本也不会升级, 否则是要安装新版本的
sudo apt install pkg_name=version_num   # 安装指定版本, apt install不可以安装deb包
sudo apt remove pkg_name  # 删除软件包的二进制文件, 不删除配置文件等
sudo apt purge pkg_name   # 删除软件同时删除配置文件, 删除所有东西, 但是不删除它依赖的包
sudo apt autoremove         # 删除一些曾经被依赖, 但是现在没有被依赖的包, 可节省磁盘空间
apt show pkg_name         # 显示包的详细信息, 无论这个包是否已经安装, 显示信息都是一样的
apt list --upgradable       # 显示可升级的包
apt list --installed        # 显示所有安装的包
apt list --all-versions     # 显示系统可安装的所有包
# ps: apt是对apt-get和apt-cache中一些常用的选项进行了一个整合, 目的是为了管理包更方便和高效
# ps: APT(advanced package tool), 是debian系统中管理包的高阶工具集合, 有apt, apt-get, aptitude等
# ps: debian中的基础包管理工具是:dpkg, dpkg是不会处理依赖关系的, 所以apt很方便.
# ps: 安装deb包:dpkg -i xx.deb; 删除:dpkg -r xx.deb, -r是--remove; 彻底删除: dpkg -P xx.deb, -P是--purge
# ps: dpkg和apt安装和卸载包时, 可以使用tab进行补全

# 38 cmake编译和安装库
cmake .         # 注意当前目录中必须有CMakeLists.txt
make -j8
make install    # 将编译好的so文件安装到系统目录中 

# 39 nitroshare安装
# 这个软件可以直接从apt安装, 但是直接安装的因为少了两个库, 无法与android连接, 所以需要源码安装
# step1: 下载qhttpengine库(https://github.com/nitroshare/qhttpengine)和qmdnsengine(https://github.com/nitroshare/qmdnsengine)
# step2: 解压两个文件, 然后进入目录, 然后cmake .; make -j8; make install;就把两个库文件安装好了
#   需要注意的是, cmake过程中可能会报错:没有 Qt5Network, 需要先安装qt5: sudo apt install qtbase5-dev
# step3: 下载nitroshare源码并解压, 然后cmake, 出现:没有FindQt5LinguistTools的错误, 则apt install qttools5-dev
#   接下来又出现没有:FindQt5Svg.cmake, 则apt install libqt5svg5-dev即可;接下来又出现没有libnotify package, 则apt install libnotify-dev
#   即可

# 40 正则表达式提取字符串
str="total 1308 samples, uar: 6.30, uap: 6.5, accuracy: 6.5"
# grep
echo $str | grep -P "\d+\.\d+" -o       # -o是只输出匹配字符串, -P是用Perl正则表达式, 其他好像不可以
find . -name "*.txt" | xargs grep -P 'regex' -o  # xargs把find的结果作为grep的输入
# sed
echo $str | sed 's/[a-zA-Z,:]//g'       # 将字母逗号分号都替换成空即可
echo here365test | sed 's/.*ere\([0-9]*\).*/\1/g'  # \1是第1个括号里边的内容
# ps: sed 不支持?, +, \d之类的正则

# sed 命令修改文件
# sed -i "s/oldstr/newstr/g" file

# 41 源码安装
# step1: ./configure --help  # 找到源码目录下的configure脚本执行, 典型的配置选项是 --prefix=install_path
# step2: make  # 如果是CMakeList.txt, 则是先cmake . 输出MakeFile文件
# step3: make install

# 42 重启gnome-shell, 重启gnome-shell后tweaks中的extension等显示才能更新
# alt + f1 + r

# 43 下载各网站视频
pip install you-get
you-get video_url -o out_dir -O out_file # -i选项可以查看支持下载的视频格式

#=======================================================================================================#

# 非常好的shell教程网站: http://c.biancheng.net/shell/

## 01 shell比较算符
# 数值比较运算符: [ -eq -ne -gt -lt -ge -le ], 不能用于字符串, 且不能用>和<, 否则被当成字符串比较
# 字符串比较符: !=, =, -z(长度为0返回true), -n(长度不为0返回true), >, <可按照ascii比较大小
#   ps: 没有>=, <=这些符号
#   ps: 在[]中时, >和<需要加反斜杠转义, 否则被认为是重定向符, 在[[]]中则不需转义
# bool运算符: !, -o ||, -a &&, 其中!用于取非, 必须和后面的表达式有一个空格, -o <=> ||, -a <=> &&
#   ps: 在[], [[]], test中, 使用-a, -o连接多个逻辑表达式, 而||, !, &&则是shell的逻辑运算符, 连接多个命令的
# 文件测试符: -d(检测目录), -e(检测是否存在), -f(检测普通文件), -r -w -x(检测可读,写,执行), -s(检测为空, 不空返回true)
#   ps: 这些也都是在[], [[]], test中使用的一些选项
# ps: 对于数字型字符串和数字, shell并不区分它们是什么类型, 但是我们需要知道的是, 用-eq这些是将它们作为数字比较, 而用
#   <, =这些则是将它们作为字符串比较
# ps: 在test, []中使用变量时, 最好都用双引号括起来, 否则如果变量不存在会出现选项没有参数的错误
# ps: 在[[]]中没有-o -a, 只有||和&&, 而在[]中, 只能用-a, -o不能用||&&, 只有[  ] || [  ]是可以的
#     总之, ||, &&, !是shell提供的逻辑运算功能, 而-o, -a, -eq等这些是命令提供的功能
# ps: &&, ||, !是shell用于多条命令执行时的逻辑判断, &&是只有前一个命令的退出状态($?)为0(执行成功)
#     才会执行后面的命令, 否则不执行后面的命令; || 则是或的关系, 前面退出状态为0, 则后面的命令不执
#     行, 为1则执行后面的命令; !则是将当前命令的$?值取反, 并且其实&&和||也是通过判断和设置$?来实现的
#     这也是为什么if后面可以用这三个符号连接多个命令的原因

## 02 shell数组(只支持一维数组)
arr=(1 2 "3" "A")   # 定义数组用()括起来,用' '或者'\n'分隔,下标从0开始
arr[0]=1;arr[1]=2;arr[2]="3";arr[3]="A" # 也可用下标定义数组,效果与上面一样的
echo ${arr[0]}      # 获取arr[0]的值,注意花括弧不能省,因为$arr是等于1的,如果省略,则$arr[0]输出1[0]
echo ${arr[@]},${arr[*]}     # 用于获取数组的所有元素
echo ${#arr[@]},${#arr[*]}   # 获取数组长度 
echo ${!arr[@]}, ${!arr[*]}  # 获取数组所有索引
# ps: 虽然arr[2]="3",但是同样可以进行数学运算的
# ps: $arr相当于是${arr[0]}, 可以通过$arr对0元素赋值, 如果先定义了数组a, 后面又有a="hello", 则
#     此时并不是定义了一个新的变量a, 而是让${a[0]}赋值为hello, 如果ss=${arr[@]}, 则$ss是整个数组
#     用空格隔开串, 因为ss已经是字符串列表了
# ps: 数组还可以其他方式定义: 
#       a=([0]=1 [2]=3), 部分元素赋值, 此时a[1]是无值的, 数组长度是2, 可以正常遍历
#       read -a arr, 交互式赋值
# ps: 数组切片: 
#       ${arr[@]:offset:number}, 获取arr[offset], arr[offset + number - 1], 如果只给一个元素, 则认为是offset
#           切片出offset开始的所有元素
#   ps: 字符串切片和数组切片类似, 但是它多一个${ss: -n}, 取结尾的n个字符, ${ss: -n: m}, 从-n开始向右取m个
#       ${ss: n:-m}, 取索引为n到-m的值, ${ss: -n:-m}, 取索引为-n到-m的值
#       注意三点: 如果n(第一个冒号后的数)是负数, 则需要和前面的:有空格; -1代表最后一个字符, -n代表右数第n个
#            这个python一样的; 字符串要索引某个位置的字符, 也只能用切片获得, 不能想数组一样用[]获取

# 遍历数组
for x in ${arr[@]};do
    echo $x                  # 每个echo后会输出一个换行, 必须是$x
done
# ps: 其实${arr[@]} 就是将数组变成字符串列表, arr=(str_list), 则是将字符串列表转换称数组
#     也就是说, 遍历数组其实就是先将数组变为字符串列表, 然后用for in 去遍历

for((i=0; i<${#arr[@]}; i++));do
    printf ${arr[i]},$i    # 不会输出换行, 单独使用i时,要加$
done

echo "hehhe"                # echo输出时, 是以空格为分割符的, 不是逗号, 所以逗号也被输出
for i in ${!arr[@]};do      # !arr[@]是取数组所有索引的意思
    printf ${arr[i]}        # i作为数组索引时,i和$i均可
    printf $i               # 单独使用时需要加$
done
echo "hehehe"

i=0
while [ $i -lt ${#arr[@]} ];do
    printf ${arr[$i]}       # 不能用print, print的输入是文件
    let i++                 # 在let表达式中使用变量可以不加$
done
echo 

# for循环的一个简写
for i in {1..10};do
    printf $i               # 12345678910
done
echo

for x in aa bb cc dd;do
    printf $x              # aabbccdd
done
# ps: 任何一个以空格隔开的字符串, 都可以用for in遍历, 并且可以看成是一个数组 
# ps: printf命令的正确使用方式是: printf format-str [arg1 arg2], 它是shell版的c语言printf
#     如: printf "%-2.4f,, %-2.4f,, %-2.4f\n" $a $b $c是可以的, 但是printf $a, $b, $c则不行, 因为
#     这样只能打印"$a,", 而后面的$b, $c无法打印, 因为printf将第一个参数看成是format-str的, 由于
#     第一个参数没有规定好打印格式, 所以后面的参数没法输出, printf $a,$b,$c 是可以正常输出
#     三个变量的, 因为此时没有空格, "$a,$b,$c"被当成一个参数了,
#     ps: printf不自动打印换行, 需要手动写出, format-str中可以包含其他任何提示字符的


## 03 shell整数算数运算
# let "表达式"              # 如果表达式比较复杂,最好是用""括起来
# 在表达式内变量可以直接访问,不需要加$
# 表达式内可以定义新的变量,并且新变量自动初始值为0
# **, %, +, -, *, /, +=, -=, *=, /=, ++, --
# 多个式子则用逗号隔开
a=10
let "a += 10"; echo $a      # 20

# (()), 是shell中专门进行整数运算的命令, 用法和let完全相同,感觉(())比用let更简洁
((a = a**2)); echo $a       # 400
# ps: (())和let还是不一样的, let 不能使用$()赋值给变量, 这样会导致表达式没有计算的, 而(())
#   则可以使用$(())将计算结果赋值给变量, 此时变量的的值是(())中最后一个表达式的值, 不过还是
#   不提倡把结果赋值给变量, 因为可能会出错
# ps: (())也可以进行逻辑运算
# ps: a=$((10 + 20, 22)), 则a=22, 用$获取(())命令的结果和用$获取变量的值是类似的

## 03.2 shell浮点计算
# bc计算器, 在命令行输入bc -lq, 可以进入bc的交互计算环境, bc是一门可编程计算语言
# a=10; b=20.0
# c=$(bc <<< "scale=2; $a / $b; d=10; $a * d; e=2.5;")  # 输出:.50, 100
# ps: bc使用shell变量时, 必须用双引号, shell变量必须加$, 否则会被当成bc内部的变量, 如上面
#     的例子, d和e是bc内部变量
# ps: 使用$()时, bc的返回值是所有表达式的值构成的字符串列表, 这里的表达式不包括赋值表达式
#     所以上面返回了$a / $b和$a * d的值, 而没有返回scale=2, d=10, e=2.5这些的值
# ps: bc计算出的浮点数, 如果是纯小数, 则是不会显示前导0的
# ps: echo $str | bc 与 bc <<< $str一般来说效果都是一样的, 但是通过管道会产生新的子进程, 而
#     <<<不会产生新的子进程

## 04 shell变量
aa=100                            # 显示定义变量
for file in $(ls .);do echo;done  # 隐式定义变量,此时变量file在for循环外也可使用

echo "I am ${aa}xixi"  # 使用变量时最好加{},用于解释器确定变量边界,如果没有{},
# 则aaxixi被解释器认为是一个变量,从而输出空值, 其实可以从颜色上看出来shell是把哪个当成变量边界的


readonly aa     # 将aa设置为readonly的,则接下来不允许修改aa,即不允许对aa重新赋值
unset aa        # 删除变量,不能删除readonly变量

# 系统变量, 注意下面的这些变量同样适用于函数
$n  # 传递给函数或本程序的参数,从$1开始
$0  # 本程序的名字
$*  # 全部参数列表, 可以用for x in $*遍历的
$@  # 同$*, 但是不适用与IFS环境变量
$?  # 上一个命令的退出状态,0是正常退出,非0则非正常退出,退出码的范围是[0,255]
$$  # 本进程的pid
$!  # 上一个命令的pid

# 将命令的执行结果输出到变量,两种方式
out=`echo "123"`
((out += 100)); echo $out       # 223
out=$(ls | grep sh); echo $out  # cmd.sh killPid.sh
# ps: 反引号和$()都可以解释命令中的shell特殊字符, 但是两者对于\的解释有区别, 在反引号中
#       一个\是反斜杠字符本身, 不是转义的, 两个才是表示用反斜杠转义, 而$()中是一个反斜杠转义
#    aa.sh中输入:echo `echo \\$HOSTNAME`; echo $(echo \\$HOSTNAME); 然后 bash -x aa.sh; 可以发
#       现前者是输出$HOSTNAME, 后者则是输出\caixiong-TM1701, 目测是``中的反斜杠必须成对才有含义
#       此时成对的反斜杠相当于一个反斜杠, 而如果是奇数个, 则最后一个反斜杠被忽略
# ps: $()是新的推荐用法, 反引号是就用法
# ps: 命令替换是说把命令的标准输出结果替代整个``和$()部分, 这里要注意的是标准输出, 也就是这条
#     命令如果有向标准输出设备有输出(一般是向屏幕打印字符串), 则把这些输出返回, 注意它不是返回
#     命令的返回值, 命令的返回值是通过$?获得的, 对于函数来说, 如果函数内部有echo, 则命令替换是
#     返回函数中的echo内容, 而要获取函数返回值, 要用$?; 还有需要注意的地方, 如果将函数调用放在
#     命令替换里边, 则在执行函数处是不会再打印函数里边的输出信息的, 这些信息只能通过命令替换后
#     的变量来输出, 这其实也是函数被当成命令的体现.也就是说命令替换的本质是在执行命令的时候把
#     命令的标准输出保存起来, 而不是真正的输出

# 变量作用域: 
#   shell脚本中的变量: 是global的, 作用域从变量定义处到shell结束或被该变量被显示删除(unset v)
#       这些变量不能用local修饰, 所以这些变量只能是全局的, local只能修饰函数内的变量
#   函数内的变量: 默认是global的, 此时的作用域从函数被调用时执行的定义变量开始到shell结束或者
#       显示删除; 如果用local修饰了, 则作用域被限制在函数内, 另外需要注意, 函数参数都是local的
# ps: 同名时, local变量会屏蔽global变量


##05 shell函数
function f1()
{
    # 函数体
    return
}

f1()
{
    # 函数体
    return      # 函数返回值通过$?来使用
}
# 函数声明: 
#   只有上面两种方式, 参数列表必须是空的, function关键字可有可无, return可有可无
#   ps: function和()两者至少有一个即可, 即f1(){}; function f1{}; function f1(){}都可以的

# 函数调用: 
#   f1 $a $b; f1; 调用函数时是不需要写括弧的, 直接写名字+空格分割的参数列表, 这是因为shell
#       把定义的函数当成一条新的命令, 所以使用方式和命令一样
#   ps: 函数必须先定义再调用, 否则会报错, 但是有的教程说可以反过来, 并且是/bin/bash, 很奇怪
#   ps: 使用函数时, 不能写v=f1 $a $b, 因为shell把f1当成字符串了, 所以一般来说, 调用语句左边
#       是没有赋值运算符的, 有时候也可以写成v=$(f1 $a $b), 这是可以的, 但是可能结果不是你想要
#       的, 因为$()是将f1(看成命令)中输出到标准输出的所有结果当初字符串数组返回的, 而不是
#       返回函数的返回值, 所以要写成f1 $a, $b; v=$?;这样v才是函数返回值

# 函数参数:
#   定义时参数列表必须为空, 调用时, 传参是在函数名后用空格隔开的, 使用时则是用$0, $1, $2来使
#       用实参, $0是shell脚本名(注:不是函数名), 如果参数下标>=10, 则要用${10}, 而不能是$10; 
#       如果使用了不存的参数, 则不会报错, 而是当成空串处理
#   特殊参数: $*和$@是所有参数构成的字符串(以空格分割, 可以遍历的); $#是参数个数
#   数组作为实参: 
#       数组作为实参传递时, 必须要写成${arr[@]}才能传递所有元素, 否则只传递数组的第一个元素
#       并且需要注意的是, fun ${arr[*]} 和 fun "${arr[*]}"是不一样的, 前者是将数组元素作为多
#       个参数传递, 后者是将数组整体作为第1个参数; 前者可以用 for x in $*来遍历, 后者可以用
#       for x in $1来遍历, 对于数组作为一个参数传递的情况, 可以在函数里写arr=($1), 就可以将
#       该参数又转换为数组了, 例子在下边
#       ps: 非常重要的一点, 只有fun "${arr[*]}"这一种才能将数组作为一个字符串传递, 就算是
#            fun "$arr[@]"都不可以, 目前还不太清楚[@]和[*]的区别, 有人说前者是分开的字串, 
#            而后者是一个字串
#       ps: 可以用bash -x 来运行脚本, 来看明白数组传参时的上述区别

# 函数返回值:
#   如果没有return语句, 则最后一条命令的返回值将被返回, 这里需要注意的是, 如果最后一个语句
#       是赋值语句, 如a=100, 则返回值不是a, 而是从a=100往上找第一个命令的返回值返回
#   只能return数值类型, 不能是字符串, 并且返回值是0-255的, 如果超过则发生截断(mod 256), 这里
#       也验证了函数其实就是定义一个新命令, 因为命令的返回值只能是0-255的, 所以不要将你需要
#       的计算结果通过return 返回, 计算结果直接存在变量(非 local)里即可!!!
#   ps: 如果是要返回变量a, 必须写成 return $a, 而不是return a, 后者是返回字符a
#   ps: return语句只能在函数中使用, 而不能在shell脚本全局使用(即使在if for等之中也不行)

# 例子:
function getsum(){
    local sum=0
    for n in $@
    do
         ((sum+=n))
    done
    echo $sum
    return 0
}
echo $(getsum 10 20 55 15)  # 这里可用命令替换, 是因为return上面的一句:echo $sum

function getsum(){
    local sum=0
    for n in $@
    do
         ((sum+=n))
    done
    return $sum
}
getsum 10 20 55 15  #调用函数并传递参数
echo $?     # 这里是通过函数返回值使用函数, 需要注意return后的数值是0-255的

# 数组作为参数传递 
fun1()
{
    echo KKK $1 KKK
    for x in $1;do 
        echo $x
    done
}

fun2()
{
    echo $1
    echo GGG $@ GGG
    for x in $@; do
        echo $x
    done
}

a=("aa" "bb" "cc")
fun1 "${a[*]}"       # 引号很重要, 有引号是一个参数, 没有引号是多个参数, 且不能用[@]
echo "================="
fun2 ${a[*]}

## 06 if语句
# 只有if分支
if cond
then
    # 判断成功的语句
    echo haha
fi

if cond; then       # then和if写在同一行时, 需要加一个分号, 这个循环等是一致的
    echo haha
fi
# 例子
read age
read iq
if ((age > 18 && iq < 60))         # (())命令不需要像[]一样要有空格
then
    echo "you are stupid"
fi

# 有else分支
if cond
then
    statements1
else
    statements2
fi
# 例子
if ((10 > 2)); then echo "hello"; else echo "world";fi  # 一行写完

# 多个分支
if cond1
then
    s1
elif cond2
then
    s2
elif cond3
then
    s3
else
    sn
fi
# ps: if和elif后面需要跟一个then, 而else则不需要then
# ps: cond是一个非常关键的事情, cond必须是一条命令, shell将它的退出状态用于判断条件是否
#     成立, [, (())这些都是命令, 它们都有一个转换功能, 就是如果它判断出条件是真的, 则它会
#     将自己的退出状态设置为0, 此时shell会判断if分支成立, 反之退出状态设置为非0, shell判断
#     if分支不成立, 这个可以做实验的, 单独使用[ 和(()), 然后手动echo $?, 就可以了. 从这里也
#     知道, 在if后面写一个数字, 或者字符串等都是没有用的.
# ps: cond 可以用 && , ||, !三个逻辑运算符进行拼接, 只是&&和||是短路的, 对于&&来说, 如果第
#     一个退出状态是非0的, 则直接结束了, 后一个命令不执行
# ps: 用(())时, 需要注意, (())放在if后是条件成立, 退出状态为0, if将0认为是条件成立, 而a=((10 > 0))
#     这种表达式时, 返回的是表达式的值, 而不是退出条件, 所以a=$((10 > 0)), a是1的
# ps: 同理, while cond也是这么个原理

# 例子:
if ./cc.sh 0; then echo "hello"; fi
read a
read b

# cc.sh
if ((a == b))
then
    exit 0
else
    exit 1
fi
# 当输入两个数相等时, 输出hello, 输入的两个数不相等时, 则没有输出hello

## case
case exp in
    pattern1)
        s1
        ;;
    pattern2)
        s2
        ;;
    *)
        sn
esac
# 这里的exp是表达式, 而不是命令了, 也就是不是判断命令的退出状态的, pattern是一个字符串, 数
#   字, 或简单正则表达式: *, 任意字符; [a5H], a 5 H中任何一个; [0-9a-zA-Z] 类似的; |, 或, abc|xyz

# 例子
read num
case $num in
    1)
        echo "Monday";;
    2)
        echo "Tuesday"
        ;;      # ;;和c中break一样的, 必不可少, 否则会报语法错误
    3)
        echo "Wednesday"
        ;;
    4)
        echo "Thursday"
        ;;
    5)
        echo "Friday"
        ;;
    6)
        echo "Saturday"
        ;;
    7)
        echo "Sunday"
        ;;
    *)
        echo "error"
esac

case $((10 > 0))  in 0) echo "00";; 1) echo "11";; esac  # 输出11
# 这里输出11是因为$((10 > 0))的值是1, 而不是(())的退出状态0, 并且不能去掉$而写成(()), 会有语法错误


## 07 循环
# for 循环两种形式
# for 01 c语言风格
for ((exp1; exp2; exp3))
do
    s
done
# 例子:
sum=0
for ((i=1; i<=100; i++))
do
    ((sum += i))
done
# ps: 此处的(())和(())命令不是一个东西, 不能混为一谈
# ps: 三个表达式可以省略任意一个或多个, for((;;;))都是可以的, for(i=0; ; i++)则相当于死循环

# for 02 python风格
for v in value_list
do
    s
done
# ps: in value_list可以省略, 此时相当于是 in $@
# ps: value_list可以是以下几种形式: 
#       01 直接给出值, 空格隔开, 如: for x in 1 2, abc 199  # 注意第二个元素是'2,'
#       02 给出一个取值范围{start..end}, 如: for x in {-10..9999}; for x in {A..z}
#           ps: 范围只能全部是数字, 或全部是字符, 并且A-z会把中间的非字母字符也算上
#       03 使用命令的执行结果, 如 for x in $(seq 0 2 100); for fname in $(ls *.sh)  
#           seq 是一个产生连续数序列的命令
#       04 使用shell通配符(glob), 如 for fname in *.sh;
#           * 任意长度任意字符; ? 任意单个字符; [list]和[^list]=[!list] list范围内和
#           外的任意单个字符; {s1, s2, s3} 匹配s1, s2, s3等字符串
#           ps: linux glob介绍 https://www.linuxidc.com/Linux/2016-08/134192.htm
#       05 使用$*, $@等特殊变量, 如 for x in $@
#       06 使用数组, 如: for x in ${arr[@]}
# ps: value_list也可以是单个元素的
# ps: seq命令介绍:
#   seq -s " " LAST; seq FIRST LAST; seq FIRST INCREMENT LAST;
#   ps: -s是指定分隔符, 默认是\n, 如果FIRST和INCREMENT没有指定, 则默认都是1
#   ps: 结果是闭区间的, 会包含FIRST和LAST(如果恰好可以包含的话), seq 0 2 10 => 0,..,10, seq 1 2 10 => 1,..,9
#   ps: 所有数值均被解释成float, seq 0, 2.2 6 => 1.0 3.2 5.4
#   ps: INCREMENT可以是负的, 此时要求FIRST > LAST

# while 循环
while cond
do
    s
done
# cond和if中cond是一样的, 可以用test, [], 或(()), [[]]
# 例子:
i=1
sum=0
while ((i <= 100))
do
    ((sum += i))
    ((i++))
done

sum=0
echo "请输入您要计算的数字，按 Ctrl+D 组合键结束读取"
while read n    # 当输入ctrl+d时, read返回非零的退出状态
do
    ((sum += n))
done

## 知识点
### 01 <<<, <<, |的区别
# cmd <<< str 是将str作为cmd的标准输入
# cmd <<END str END 是将END作为marker, 在两个marker之间的输入作为cmd的标准输入
# echo str | cmd 是将str作为cmd的输入, 但是管道会创建一个子进程的

# 1,118s/\n/\r#/
# 1,118s/\n#/\r/
