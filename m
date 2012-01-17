From: "Srinivasan, Nageswari" <nageswari-l0cyMroinI0@public.gmane.org>
Subject: I2C_RDRW_IOCTL_MAX_MSGS
Date: Tue, 17 Jan 2012 10:56:43 +0000
Message-ID: <464859D4BE03A84686BA47749242C1D0317B66EC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Is there any specific reason to limit no of i2c messages 
to 42 in i2c-dev.c file

/* Put an arbitrary limit on the number of messages that can
         * be sent at once */
        if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
                return -EINVAL;

Regards,
Nageswari
