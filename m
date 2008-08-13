From: Laurence Mayer <laurence-AgvQzd4wkYRiL9xFr9M+9AC/G2K4zDHf@public.gmane.org>
Subject: Struggling to make this work...
Date: Wed, 13 Aug 2008 18:06:14 +0300
Message-ID: <48A2F866.5070705@istraresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7673702378591766471=="
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

--===============7673702378591766471==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body dir="ltr" bgcolor="#ffffff" text="#000000">
Hi,<br>
Please can you help.<br>
<br>
I have literally spent days-on-end trying to get this working with
absolutely no progress.<br>
<br>
Please let me know if you require furhter information.<br>
<br>
<br>
See below:<br>
<br>
<br>
Hardware: DELL 2950<br>
<br>
[root@fs1 ~]# uname -a<br>
Linux fs1 2.6.18-92.1.6.el5 #1 SMP Tue Jul 8 14:27:51 EDT 2008 x86_64
x86_64 x86_64 GNU/Linux<br>
<br>
[root@fs1 ~]# sensors-detect <br>
# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)<br>
<br>
[root@fs1 ~]# lsmod | grep i2c<br>
i2c_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 43849&nbsp; 0 <br>
i2c_ec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38593&nbsp; 1 sbs<br>
i2c_core&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56129&nbsp; 2 i2c_dev,i2c_ec<br>
<br>
[root@fs1 ~]# lsmod |grep -i processor<br>
Returns nothing<br>
<br>
[root@fs1 ~]# lsmod |grep -i thermal<br>
Returns nothing<br>
<br>
[root@fs1 ~]# mount<br>
/dev/sda3 on / type ext3 (rw)<br>
proc on /proc type proc (rw)<br>
sysfs on /sys type sysfs (rw)<br>
devpts on /dev/pts type devpts (rw,gid=5,mode=620)<br>
/dev/sda1 on /boot type ext3 (rw)<br>
tmpfs on /dev/shm type tmpfs (rw)<br>
/dev/sdb1 on /home type ext3 (rw)<br>
/dev/sdb2 on /public type ext3 (rw)<br>
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)<br>
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)<br>
nfsd on /proc/fs/nfsd type nfsd (rw)<br>
<br>
<br>
[root@fs1 etc]# lspci <br>
00:00.0 Host bridge: Intel Corporation 5000X Chipset Memory Controller
Hub (rev 12)<br>
00:02.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 2 (rev 12)<br>
00:03.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 3 (rev 12)<br>
00:04.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x8 Port 4-5 (rev 12)<br>
00:05.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 5 (rev 12)<br>
00:06.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x8 Port 6-7 (rev 12)<br>
00:07.0 PCI bridge: Intel Corporation 5000 Series Chipset PCI Express
x4 Port 7 (rev 12)<br>
00:10.0 Host bridge: Intel Corporation 5000 Series Chipset FSB
Registers (rev 12)<br>
00:10.1 Host bridge: Intel Corporation 5000 Series Chipset FSB
Registers (rev 12)<br>
00:10.2 Host bridge: Intel Corporation 5000 Series Chipset FSB
Registers (rev 12)<br>
00:11.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved
Registers (rev 12)<br>
00:13.0 Host bridge: Intel Corporation 5000 Series Chipset Reserved
Registers (rev 12)<br>
00:15.0 Host bridge: Intel Corporation 5000 Series Chipset FBD
Registers (rev 12)<br>
00:16.0 Host bridge: Intel Corporation 5000 Series Chipset FBD
Registers (rev 12)<br>
00:1c.0 PCI bridge: Intel Corporation 631xESB/632xESB/3100 Chipset PCI
Express Root Port 1 (rev 09)<br>
00:1d.0 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #1 (rev 09)<br>
00:1d.1 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #2 (rev 09)<br>
00:1d.2 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #3 (rev 09)<br>
00:1d.3 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
UHCI USB Controller #4 (rev 09)<br>
00:1d.7 USB Controller: Intel Corporation 631xESB/632xESB/3100 Chipset
EHCI USB2 Controller (rev 09)<br>
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d9)<br>
00:1f.0 ISA bridge: Intel Corporation 631xESB/632xESB/3100 Chipset LPC
Interface Controller (rev 09)<br>
00:1f.1 IDE interface: Intel Corporation 631xESB/632xESB IDE Controller
(rev 09)<br>
01:00.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID SAS
1078 (rev 04)<br>
02:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev c3)<br>
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708
Gigabit Ethernet (rev 12)<br>
04:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express
Upstream Port (rev 01)<br>
04:00.3 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express to
PCI-X Bridge (rev 01)<br>
05:00.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express
Downstream Port E1 (rev 01)<br>
05:01.0 PCI bridge: Intel Corporation 6311ESB/6321ESB PCI Express
Downstream Port E2 (rev 01)<br>
06:00.0 PCI bridge: Broadcom EPB PCI-Express to PCI-X Bridge (rev c3)<br>
07:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5708
Gigabit Ethernet (rev 12)<br>
0e:0d.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)<br>
<br>
<br>
<br>
<br>
ERROR:<br>
<br>
This program will help you determine which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>
unless you know what you're doing.<br>
<br>
We can start with probing for (PCI) I2C or SMBus adapters.<br>
Do you want to probe now? (YES/no): <br>
Probing for PCI bus adapters...<br>
Sorry, no supported PCI bus adapters found.<br>
<br>
If you have undetectable or unsupported I2C/SMBus adapters, you can have<br>
them scanned by manually loading the modules before running this script.<br>
<br>
We are now going to do the I2C/SMBus adapter probings. Some chips may<br>
be double detected; we choose the one with the highest confidence<br>
value in that case.<br>
If you found that the adapter hung after probing a certain address,<br>
you can specify that address to remain unprobed.<br>
<br>
Some chips are also accessible through the ISA I/O ports. We have to<br>
write to arbitrary I/O ports to probe them. This is usually safe though.<br>
Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>
Do you want to scan the ISA I/O ports? (YES/no): <br>
Probing for `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `National Semiconductor LM78-J' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83782D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `IPMI BMC SMIC' at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Some Super I/O chips may also contain sensors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): <br>
Probing for Super-I/O at 0x2e/0x2f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
Found unknown chip with ID 0x6701<br>
Probing for Super-I/O at 0x4e/0x4f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Some south bridges, CPUs or memory controllers may also contain<br>
embedded sensors. Do you want to scan for them? (YES/no): <br>
Silicon Integrated Systems SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA VT82C686 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA VT8231 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD K10 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>
&nbsp;&nbsp;&nbsp; (driver `coretemp')<br>
Intel AMB FB-DIMM thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>
&nbsp;&nbsp;&nbsp; (driver `to-be-written')<br>
<br>
Now follows a summary of the probes I have just done.<br>
Just press ENTER to continue: <br>
<br>
Driver `coretemp' (should be inserted):<br>
&nbsp; Detects correctly:<br>
&nbsp; * Chip `Intel Core family thermal sensor' (confidence: 9)<br>
<br>
Driver `to-be-written' (should be inserted):<br>
&nbsp; Detects correctly:<br>
&nbsp; * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)<br>
<br>
Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): <br>
Starting lm_sensors: Can't access procfs/sysfs file<br>
Unable to find i2c bus information;<br>
For 2.6 kernels, make sure you have mounted sysfs and libsensors<br>
was compiled with sysfs support!<br>
For older kernels, make sure you have done 'modprobe i2c-proc'!<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [FAILED]<br>
<br>
<br>
</body>
</html>


--===============7673702378591766471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============7673702378591766471==--
