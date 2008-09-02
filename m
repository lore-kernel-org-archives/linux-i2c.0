From: xiaowinky <nanguangzhixing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: FW: HELP ME! DM355 EVM MT9T001 question!
Date: Tue, 2 Sep 2008 16:12:12 +0800
Message-ID: <BLU111-W29C3C7F31A809BD3619E3FB75F0@phx.gbl>
References: <rUwzhhPSZ00096e49@blu0-omc2-s21.blu0.hotmail.com>
	<BLU111-W21AE70F6BF9A6CFACB1D7AB7600@phx.gbl>
	<AEA06231B7D16F4CA77C0C1550F3D73005DDD727@sin2apfpew01.ap.sanm.corp>
	<BLU111-W438DFF6CC1D3E1028E9BB1B7600@phx.gbl>
	<bfd52c5b0808280642o5d30b0f1g77240bd5e0165b16@mail.gmail.com>
	<BLU111-W4910427AB2C320E39BF04CB75C0@phx.gbl>
	<20080902091532.0f4319ad@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8466662199112234085=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080902091532.0f4319ad-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============8466662199112234085==
Content-Type: multipart/alternative;
	boundary="_2811a4c1-7832-4ee3-bfb9-e5ec791f3c00_"

--_2811a4c1-7832-4ee3-bfb9-e5ec791f3c00_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit

hi,Jean!  my kernel version is 2.6.10_mvl401!I use "#i2cdetect 0"command to probe the I2C address range,I get a long list (shown below) > >WARNING! This program can confuse your I2C bus, cause data loss and worse!> > I will probe file /dev/i2c/0.> > I will probe address range 0x03-0x77.> > Continue? [Y/n]I do not understand above meaning,Please advise!sorry for my english. Thanks your reply, winkyxiao!

> Date: Tue, 2 Sep 2008 09:15:32 +0200> From: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> To: nanguangzhixing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org> CC: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org> Subject: Re: [i2c] FW: HELP ME! DM355 EVM MT9T001 question!> > On Tue, 2 Sep 2008 01:35:00 +0800, xiaowinky wrote:> > hi,all!> > I use the i2c-tools-3.0.1 tool to compile and install in DM355 EVM kernel,> > Which kernel version are you using?> > > For example with orders #i2cdetect 0,> > prompts following information:> > WARNING! This program can confuse your I2C bus, cause data loss and worse!> > I will probe file /dev/i2c/0.> > I will probe address range 0x03-0x77.> > Continue? [Y/n]> > What is the output of this command?> > > Then the basis bus address range 0x03-0x07,orders the test with below:> > #i2cdump 0 0x03-0x77,> > only 0x5D and 0x1B two bus addresses are ef
 fective, For example # i2cdump 0 0x5d> > prompt the information to be as follows:> > No size specified (using byte-data access)> > Error: Could not set address to 0x5d: Device or resource busy> > This means that there's already a kernel driver bound to this device.> To find out which it is, you can follow the driver link> in /sys/bus/i2c/devices/0-005d.> > To solve this, you can either unload the driver in question (with> rmmod), or you can pass option "-f" to i2cdump to force i2c-dev to> access the device even though it is busy. But beware that this might> confuse the kernel driver that is bound to the device, so this is> generally discouraged.> > > > > Other bus address is invalid, For example : # i2cdump 0 0x3a> > prompts the information to be as follows:> > No size specified (using b
 yte-data access)> > WARNING! This program can confuse your I2C bus, cause data loss and worse!> > I will probe file /dev/i2c/0, address 0x3a, mode byte> > Continue? [Y/n]> > > > Whether only 0x5D and the 0xB1 two device address hang on the I2C bus ???> > I don't understand this question, sorry. Please rephrase in proper> English.> > -- > Jean Delvare
_________________________________________________________________
谈话枯燥无味？让MSN魔法书来点缀您的MSN！
http://im.live.cn/emoticons/?ID=6
--_2811a4c1-7832-4ee3-bfb9-e5ec791f3c00_
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
<body class='hmmessage'>hi,Jean!<BR>&nbsp; my kernel version is 2.6.10_mvl401!<BR>I use "#i2cdetect 0"command&nbsp;to&nbsp;probe the I2C address range,<BR>I get a long list (shown below)<BR>&nbsp;<BR>&gt; &gt;WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>&gt; &gt; I will probe file /dev/i2c/0.<BR>&gt; &gt; I will probe address range 0x03-0x77.<BR>&gt; &gt; Continue? [Y/n]<BR><BR>I do not understand above meaning,Please advise!<BR>sorry for my english.<BR>&nbsp;Thanks your reply,<BR>&nbsp;winkyxiao!<BR><BR><BR><BR><BR>
<HR id=stopSpelling>
&gt; Date: Tue, 2 Sep 2008 09:15:32 +0200<BR>&gt; From: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org<BR>&gt; To: nanguangzhixing-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org<BR>&gt; CC: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org<BR>&gt; Subject: Re: [i2c] FW: HELP ME! DM355 EVM MT9T001 question!<BR>&gt; <BR>&gt; On Tue, 2 Sep 2008 01:35:00 +0800, xiaowinky wrote:<BR>&gt; &gt; hi,all!<BR>&gt; &gt; I use the i2c-tools-3.0.1 tool to compile and install in DM355 EVM kernel,<BR>&gt; <BR>&gt; Which kernel version are you using?<BR>&gt; <BR>&gt; &gt; For example with orders #i2cdetect 0,<BR>&gt; &gt; prompts following information:<BR>&gt; &gt; WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>&gt; &gt; I will probe file /dev/i2c/0.<BR>&gt; &gt; I will probe address range 0x03-0x77.<BR>&gt; &gt; Continue? [Y/n]<BR>&gt; <BR>&gt; What is the output of t
 his command?<BR>&gt; <BR>&gt; &gt; Then the basis bus address range 0x03-0x07,orders the test with below:<BR>&gt; &gt; #i2cdump 0 0x03-0x77,<BR>&gt; &gt; only 0x5D and 0x1B two bus addresses are effective, For example # i2cdump 0 0x5d<BR>&gt; &gt; prompt the information to be as follows:<BR>&gt; &gt; No size specified (using byte-data access)<BR>&gt; &gt; Error: Could not set address to 0x5d: Device or resource busy<BR>&gt; <BR>&gt; This means that there's already a kernel driver bound to this device.<BR>&gt; To find out which it is, you can follow the driver link<BR>&gt; in /sys/bus/i2c/devices/0-005d.<BR>&gt; <BR>&gt; To solve this, you can either unload the driver in question (with<BR>&gt; rmmod), or you can pass option "-f" to i2cdump to force i2c-dev to<BR>&gt; access the device eve
 n though it is busy. But beware that this might<BR>&gt; confuse the kernel driver that is bound to the device, so this is<BR>&gt; generally discouraged.<BR>&gt; <BR>&gt; &gt; <BR>&gt; &gt; Other bus address is invalid, For example : # i2cdump 0 0x3a<BR>&gt; &gt; prompts the information to be as follows:<BR>&gt; &gt; No size specified (using byte-data access)<BR>&gt; &gt; WARNING! This program can confuse your I2C bus, cause data loss and worse!<BR>&gt; &gt; I will probe file /dev/i2c/0, address 0x3a, mode byte<BR>&gt; &gt; Continue? [Y/n]<BR>&gt; &gt; <BR>&gt; &gt; Whether only 0x5D and the 0xB1 two device address hang on the I2C bus ???<BR>&gt; <BR>&gt; I don't understand this question, sorry. Please rephrase in proper<BR>&gt; English.<BR>&gt; <BR>&gt; -- <BR>&gt; Jean Delvare<BR><br />
 <hr />使用新一代 Windows Live Messenger 轻松交流和共享！ <a href='http://im.live.cn/' target='_new'>立刻下载！</a></body>
</html>
--_2811a4c1-7832-4ee3-bfb9-e5ec791f3c00_--


--===============8466662199112234085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8466662199112234085==--
