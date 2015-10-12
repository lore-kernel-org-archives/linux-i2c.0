From: Alexandre Daoud <alex.daoud@mac.com>
Subject: i2c-hid: null input report
Date: Mon, 12 Oct 2015 13:02:58 +0100
Message-ID: <CA13886C-4161-4430-B234-7471773759FF@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from st11p01im-asmtp001.me.com ([17.172.204.151]:32882 "EHLO
	st11p01im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbbJLNGs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 09:06:48 -0400
Received: from [10.213.145.251]
 (ip-31-205-85-157.ask4internet.com [31.205.85.157])
 by st11p01im-asmtp001.me.com
 (Oracle Communications Messaging Server 7.0.5.35.0 64bit (built Mar 31 2015))
 with ESMTPSA id <0NW3013WXWAC7K00@st11p01im-asmtp001.me.com> for
 linux-i2c@vger.kernel.org; Mon, 12 Oct 2015 12:06:40 +0000 (GMT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hey guys,

I have a non-Linux i2c-hid related issue that I hope I could get some h=
elp with. I have been porting the bus drivers for the Lynxpoint LPSS I2=
C controllers and also the i2c-hid device drivers to OS X. Thanks to he=
lp from this list earlier last year, the porting is almost finished. I =
am having an issue with a synaptics touchscreen device though, in parti=
cular: =93SYNA7500=94. Whenever I try to read from the device for an in=
put report (whether by just issuing a read with i2c_master_recv or by r=
eading from the input register), all I get is a null report (in other w=
ords, just 0x00 * wMaxInputLength). Even while touching the screen with=
 both my finger and the stylus, the report stays null.

I am confident the driver is functional to at least a good level as som=
eone with an =93ATML1000=94 gets the correct input reports (and we are =
successfully able to pass them to OS X=92s HID manager).

Has anyone here experienced something similar to this? Any help would b=
e greatly appreciated.

Regards,
Alexandre Daoud