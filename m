From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Q: I2C multiplexer support
Date: Mon, 07 Dec 2009 10:07:54 +0100
Message-ID: <4B1CC5EA.7040902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

on my current project I'm now at the point to have to implement
multiplexer support. The last patch set from Rodolfo was for 2.6.29,
most parts seem to have been integrated already in 2.6.31
If I got it correctly the patch based on creating a mux folder with
i2c-mux.c as a core file and then additional mux layer files.
So my questions:
Rodolfo, do you have a more resent patch set?
Jean, what are your plans about multiplexer support, where do you see
open issues? Do you agree with current centralized layout or would you
prefer independent single files integrating all necessary parts and
residing in bus folder?

-- 
Kind Regards,

Michael
