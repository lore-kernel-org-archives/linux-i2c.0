From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto-PIIpFW8S9c0@public.gmane.org>
Subject: [2.6.31] ir-kbd-i2c oops.
Date: Wed, 16 Sep 2009 03:00:28 +0200
Message-ID: <200909160300.28382.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

hi,

the latest 2.6.31 kernel oopses in ir-kbd-i2c on my box:
afaics the 2.6.28.10 is also affected.

http://imgbin.org/index.php?page=3Dimage&id=3D776
http://imgbin.org/index.php?page=3Dimage&id=3D777
http://imgbin.org/index.php?page=3Dimage&id=3D778

installed pinnacle tv card with infra-red receiver:

05:00.0 Multimedia controller: Philips Semiconductors SAA7133/SAA7135
        Video Broadcast Decoder (rev d1)
        Subsystem: Pinnacle Systems Inc. PCTV 110i (saa7133)
        Kernel driver in use: saa7134
        Kernel modules: saa7134

if you need i'll provide more information.
please, CC me on reply.

BR, Pawe=C5=82.
