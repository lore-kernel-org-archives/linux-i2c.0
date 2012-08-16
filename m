From: John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] I2C: MIPS: lantiq: add FALC-ON i2c bus master
Date: Thu, 16 Aug 2012 11:02:46 +0200
Message-ID: <502CB736.6010107@openwrt.org>
References: <1345102448-4612-1-git-send-email-blogic@openwrt.org> <CAM=Q2cvCmKMkQjWd0nvuvMMkNt3sH-AcupCq_KzM7EXDuD_-wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cvCmKMkQjWd0nvuvMMkNt3sH-AcupCq_KzM7EXDuD_-wQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Shubhrajyoti,

Thanks for the comments, I just noticed that clk_put() is also missing
and that the clock gate should be deactivated upon a rmmod ... i will
fix all of these and resend the patch.

John
