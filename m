From: xiaowinky <nanguangzhixing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: sensor mt9t001 i2c question
Date: Fri, 5 Sep 2008 11:51:47 +0800
Message-ID: <BLU111-W20532C9F3A95AB6DD3956DB7580@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6785544255342918394=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============6785544255342918394==
Content-Type: multipart/alternative;
	boundary="_ffb6d112-aeca-4732-bd1d-934dae9a4f8d_"

--_ffb6d112-aeca-4732-bd1d-934dae9a4f8d_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit

hi,all!


I use the Montavist version, I installed  I2C-tools software tools in linux2.6.10.My system to mount a two I2C devicesroot-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices# ls0-001b  0-005din fact,0-005d is mt9t001 equipment slave address.I need to debug it.Step 1: Identify the I2C buses root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:~# i2cdetect li2c-0   i2c             DAVINCI I2C adapter                     I2C adapterStep 2: Query the I2C bus root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:~# i2cdetect 0WARNING! This program can confuse your I2C bus, cause data loss and worse!I will probe file /dev/i2c/0.I will probe address range 0x03-0x77.Continue? [Y/n] yDaVinci I2C WARNING: i2c: RAR detected-- DaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinc
 i I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detected--DaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: NACK detectedDaVinci I2C WARNING: i2c: RAR detected--Why is there the above information.I do not know what is the meaning . Step 4: Dump the I2C device registers  root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices# i2cdump -f 0 0x5d wWARNING! This 
 program can confuse your I2C bus, cause data loss and worse!I will probe file /dev/i2c/0, address 0x5d, mode word /*Because MT9T001 register for the two byte*/Continue? [Y/n] y            .........38: DaVinci I2C WARNING: i2c: RAR detected0000 0000 0000 0DaVinci I2C WARNING: i2c: RAR detected000 1000 0500 03DaVinci I2C WARNING: i2c: RAR detected00 0200DaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detected      ..........DaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedDaVinci I2C WARNING: i2c: RAR detectedf8: 0100 0000 3623 00a4 3800 20d0 0000 1116 Why 
 is there the above information.I do not know what is the meaning . i2cget and i2cset root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices# i2cset -f 0 0x5d 0x00 0x1611 wWARNING! This program can confuse your I2C bus, cause data loss and worse!I will write to device file /dev/i2c/0, chip address 0x5d, data address0x00, data 0x1611, mode word.Continue? [Y/n] yDaVinci I2C WARNING: i2c: RAR detectedWarning - data mismatch - wrote 0x1611, read back 0x1116 Why is there the above information.I do not know what is the meaning . Hope that everyone can help me! thanks winkyxiao!      
_________________________________________________________________
一点即聊，MSN推出新功能“点我！”
http://im.live.cn/click/
--_ffb6d112-aeca-4732-bd1d-934dae9a4f8d_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>hi,all!<BR><BR>
<META content="Microsoft SafeHTML" name=Generator>
<STYLE>
.ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass body.EC_hmmessage
{font-size:9pt;font-family:Tahoma;}
</STYLE>
I use the Montavist version, I installed&nbsp; I2C-tools software tools in linux2.6.10.<BR>My system to mount a two I2C devices<BR><A href="mailto:root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices">root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices</A># ls<BR>0-001b&nbsp; 0-005d<BR><BR>in fact,0-005d is mt9t001 equipment&nbsp;slave address.I need to debug it.<BR>Step 1: Identify the I2C buses<A class=EC_anchor title="Link to this section" href="http://lm-sensors.org/wiki/i2cToolsDocumentation#Step1:IdentifytheI2Cbuses" target=_blank><U><FONT color=#0066cc> </FONT></U></A><BR><A href="mailto:root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org">root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org</A>:~# i2cdetect l<BR>i2c-0&nbsp;&nbsp; i2c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DAVINCI I2C adapter&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&
 nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2C adapter<BR>Step 2: Query the I2C bus<U><FONT color=#0066cc> </FONT></U><BR><A href="mailto:root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org">root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org</A>:~# i2cdetect 0<BR>WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>I will probe file /dev/i2c/0.<BR>I will probe address range 0x03-0x77.<BR>Continue? [Y/n] y<BR><FONT color=#ff0000>DaVinci I2C WARNING: i2c: RAR detected<BR>-- DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR dete
 cted<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>--DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: NACK detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>--</FONT><BR>Why is there the above information.I do not know what is the meaning .<BR>&nbsp;<BR>Step 4: Dump the I2C device registers<U><FONT color=#0066cc> </FONT></U><BR>&nbsp;<BR><A href="mailto:root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices">root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/device
 s</A># i2cdump -f 0 0x5d w<BR>WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>I will probe file /dev/i2c/0, address 0x5d, mode word <FONT color=#333399>/*Because MT9T001 register for the two byte*/<BR></FONT>Continue? [Y/n] y<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;</FONT><FONT color=#ff0000>.........</FONT><BR><FONT color=#ff0000>38: DaVinci I2C WARNING: i2c: RAR detected<BR>0000 0000 0000 0DaVinci I2C WARNING: i2c: RAR detected<BR>000 1000 0500 03DaVinci I2C WARNING: i2c: RAR detected<BR>00 0200<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<
 BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..........</FONT><BR><BR><FONT color=#ff0000>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>DaVinci I2C WARNING: i2c: RAR detected<BR>f8: 0100 0000 3623 00a4 3800 20d0 0000 1116</FONT><BR><FONT color=#ff0000></FONT>&nbsp;<BR>Why is there the above information.I do not know what is the meaning .<BR><FONT color=#ff0000><FONT color=#333333></FONT></FONT>&nbsp;<BR><FONT color=#ff0000><FONT color=#333333>i2cget and i2cset</FONT></FONT><BR><FONT color=#333333></FONT>&nbsp;<BR><A href="mailto:root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices">root-Q0ErXNX1RuaDsJNAON/JYg@public.gmane.org:/sys/bus/i2c/devices</A># i2cset -f 0 0x5d 0x00 0x1611 w<BR>WARNING! This program can confus
 e your I2C bus, cause data loss and worse!<BR>I will write to device file /dev/i2c/0, chip address 0x5d, data address<BR>0x00, data 0x1611, mode word.<BR>Continue? [Y/n] y<BR><FONT color=#ff0000>DaVinci I2C WARNING: i2c: RAR detected<BR>Warning - data mismatch - wrote 0x1611, read back 0x1116</FONT><BR><FONT color=#ff0000></FONT>&nbsp;<BR>Why is there the above information.I do not know what is the meaning .<BR>&nbsp;<BR>Hope that everyone can help me!<BR>&nbsp;<BR>thanks<BR>&nbsp;<BR>winkyxiao!<BR><FONT color=#ff0000></FONT>&nbsp;<BR><FONT color=#ff0000></FONT><FONT color=#ff0000>&nbsp;<BR><BR><BR></FONT><BR>&nbsp;<BR><FONT color=#ff0000><FONT color=#333333></FONT>&nbsp;<BR><BR><BR></FONT><BR>&nbsp;<BR><BR>&nbsp;<BR><br /><hr />MSN上小游戏，工作休闲两不误！ <a href='http://im.live.cn/mi
 nigame' target='_new'>马上就开始玩！</a></body>
</html>
--_ffb6d112-aeca-4732-bd1d-934dae9a4f8d_--


--===============6785544255342918394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6785544255342918394==--
