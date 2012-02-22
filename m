From: Richard Retanubun <richardretanubun-4VtgCsEi+FIybS5Ee8rs3A@public.gmane.org>
Subject: eg20t i2c driver: missing some changes?
Date: Wed, 22 Feb 2012 14:46:02 -0500
Message-ID: <4F4545FA.9050105@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi

I am using i2c-eg20t on linux 3.1.6 and comparing with the current source on 3.3-rc4

I think there is a (few) missing cleanup between the version pasted on:
http://www.spinics.net/lists/linux-i2c/msg06664.html

to the one in version 3.3-rc4

one of it is this change in pch_i2c_getack

@@ -348,7 +347,7 @@
  	reg_val = ioread32(p + PCH_I2CSR) & PCH_GETACK;

  	if (reg_val != 0) {
-		pch_err(adap, "return%d\n", -EPROTO);
+		pch_dbg(adap, "return%d\n", -EPROTO);
  		return -EPROTO;
  	}

Without this change, using i2cdetect will generate a lot of false positive errors on devices that are not present.
I'm not sure if there is a patch that is missed or still being reviewed that contained this change

There are also some other differences between the mailing list version and linux-3.3rc4 in addition to this one,
but I don't have enough background to comment on them.

-- 
Richard Retanubun
