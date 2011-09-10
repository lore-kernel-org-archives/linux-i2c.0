From: "Michal Zatloukal" <myxal.mxl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Can't read DIMM SPD info (DDR2)
Date: Sat, 10 Sep 2011 21:19:30 +0200
Message-ID: <op.v1lxasq616tawo@esprimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
I'm unable to get decode-dimms to display SPD info from my memory modules.
Can someone please advise on finding the problem? The eeprom module is
loaded. This is on both my main system (Kubuntu 10.10) - 2.6.35 kernel,
i2c-tools 3.0.3-5 - and "latest" (Kubuntu 11.10 daily) - linux 3.0,
lm-sensors 3.3.0-4 and i2c-tools 3.0.3-5). The HW is a Fujitsu Esprimo
Mobile U9200 laptop (intel GM965). FWIW, the memtest that ships with
'buntu 11.10 (4.20 I think) reads the SPD info successfully.

Cheers and TIA,
MZ

-- 
Using Opera's revolutionary email client: http://www.opera.com/mail/
