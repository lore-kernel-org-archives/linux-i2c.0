From: "Konrad Bojar" <kbojar-NlWvg49iv0c@public.gmane.org>
Subject: Transmission over Intel SCH US15W SMBus interface
Date: Wed, 23 Sep 2009 15:25:36 +0200 (CEST)
Message-ID: <4055.10.1.5.69.1253712336.squirrel@ni.piap.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 charset=utf-8;
 boundary="----75ca71c8e8632d24cb6b7838e2c08c0d----"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

------75ca71c8e8632d24cb6b7838e2c08c0d----
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

I am considering developing a real-time transmission of little data, but
arriving on an irregular basis. There is a rather strict requirement for
this to be done using SMBus and RT Linux. I already know that the chipset
in question is well supported and that the task is feasible from that
point of view. What I do not know is how this will impact the overall
system performace, since I have found no information wheter the only way
to do the SMBus transmission is to use polling at SMBus frequency
(400kHz). Is this bus buffered internally by the chipset? Do you have any
info on that issue? Thanks in advance, Konrad Bojar

------75ca71c8e8632d24cb6b7838e2c08c0d----
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--
This message has been scanned by Kaspersky Anti-Virus.
For more information about data security please visit
http://www.kaspersky.com and http://www.viruslist.com

------75ca71c8e8632d24cb6b7838e2c08c0d------
