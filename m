From: "Alexander Beregalov" <a.beregalov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c_piix4/HT1000: cant read SPD data
Date: Thu, 25 Sep 2008 19:20:38 +0400
Message-ID: <a4423d670809250820p7b748980x59e6c62ccc4af209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
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

Hi

Kernel version is 2.6.27-rc7-00094-gc0f4d6d

[    6.148390] piix4_smbus 0000:00:02.0: Using Interrupt 9 for SMBus.
[    6.148397] piix4_smbus 0000:00:02.0: SMBus Host Controller at
0x580, revision 0
[    6.148707] i2c-adapter i2c-0: adapter [SMBus PIIX4 adapter at
0580] registered
[    6.148921] i2c-dev: adapter [SMBus PIIX4 adapter at 0580]
registered as minor 0

I enabled all i2c drivers as modules, but sensors-detect detects only
i2c-piix4 and k8temp.

localhost ~ # i2cdetect -l
i2c-0   smbus           SMBus PIIX4 adapter at 0580             SMBus adapter

localhost ~ # i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

[  176.357904] i2c-adapter i2c-0: ioctl, cmd=0x705, arg=0x7fff19cd4100
[  181.921907] i2c-adapter i2c-0: ioctl, cmd=0x705, arg=0x7fff3576f520
[  190.555473] i2c-adapter i2c-0: ioctl, cmd=0x705, arg=0x7fffed3558a0
[  192.228866] i2c-adapter i2c-0: ioctl, cmd=0x703, arg=0x03
[  192.228877] i2c-adapter i2c-0: ioctl, cmd=0x720, arg=0x7fffed355890
[  192.228942] i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=05,
ADD=06, DAT0=ff, DAT1=00
[  192.240017] i2c-adapter i2c-0: Error: no response!
[  192.240048] i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=05,
ADD=06, DAT0=ff, DAT1=00
[  192.240067] i2c-adapter i2c-0: ioctl, cmd=0x703, arg=0x04
[  192.240072] i2c-adapter i2c-0: ioctl, cmd=0x720, arg=0x7fffed355890
[  192.240092] i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=05,
ADD=08, DAT0=ff, DAT1=00
[  192.260027] i2c-adapter i2c-0: Error: no response!
[  192.260057] i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=05,
ADD=08, DAT0=ff, DAT1=00
[  192.260075] i2c-adapter i2c-0: ioctl, cmd=0x703, arg=0x05
[  192.260079] i2c-adapter i2c-0: ioctl, cmd=0x720, arg=0x7fffed355890
[  192.260101] i2c-adapter i2c-0: Transaction (pre): CNT=00, CMD=05,
ADD=0a, DAT0=ff, DAT1=00
[  192.280016] i2c-adapter i2c-0: Error: no response!
[  192.280046] i2c-adapter i2c-0: Transaction (post): CNT=00, CMD=05,
ADD=0a, DAT0=ff, DAT1=00
[  192.280063] i2c-adapter i2c-0: ioctl, cmd=0x703, arg=0x06
[  192.280067] i2c-adapter i2c-0: ioctl, cmd=0x720, arg=0x7fffed355890
... and so on...

System is IBM x3455

00:01.0 PCI bridge [0604]: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge
[1166:0036]
00:02.0 Host bridge [0600]: Broadcom BCM5785 [HT1000] Legacy South
Bridge [1166:0205]
00:02.1 IDE interface [0101]: Broadcom BCM5785 [HT1000] IDE [1166:0214]
00:02.2 ISA bridge [0601]: Broadcom BCM5785 [HT1000] LPC [1166:0234]
00:03.0 USB Controller [0c03]: Broadcom BCM5785 [HT1000] USB
[1166:0223] (rev 01)
00:03.1 USB Controller [0c03]: Broadcom BCM5785 [HT1000] USB
[1166:0223] (rev 01)
00:03.2 USB Controller [0c03]: Broadcom BCM5785 [HT1000] USB
[1166:0223] (rev 01)
00:05.0 VGA compatible controller [0300]: ATI Technologies Inc ES1000
[1002:515e] (rev 02)
00:06.0 PCI bridge [0604]: Broadcom HT2100 PCI-Express Bridge
[1166:0140] (rev a2)
00:07.0 PCI bridge [0604]: Broadcom HT2100 PCI-Express Bridge
[1166:0142] (rev a2)
00:08.0 PCI bridge [0604]: Broadcom HT2100 PCI-Express Bridge
[1166:0144] (rev a2)
00:09.0 PCI bridge [0604]: Broadcom HT2100 PCI-Express Bridge
[1166:0142] (rev a2)
00:0a.0 PCI bridge [0604]: Broadcom HT2100 PCI-Express Bridge
[1166:0144] (rev a2)
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map [1022:1101]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller [1022:1102]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control [1022:1103]
00:19.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
00:19.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map [1022:1101]
00:19.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller [1022:1102]
00:19.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control [1022:1103]
01:0d.0 PCI bridge [0604]: Broadcom BCM5785 [HT1000] PCI/PCI-X Bridge
[1166:0104] (rev c0)
01:0e.0 RAID bus controller [0104]: Broadcom BCM5785 [HT1000] SATA
(Native SATA Mode) [1166:024a]
02:01.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme
BCM5704 Gigabit Ethernet [14e4:1648] (rev 10)
02:01.1 Ethernet controller [0200]: Broadcom Corporation NetXtreme
BCM5704 Gigabit Ethernet [14e4:1648] (rev 10)

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
