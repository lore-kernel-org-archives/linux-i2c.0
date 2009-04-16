From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Questions for submitting driver to I2C subsystem
Date: Thu, 16 Apr 2009 11:14:36 +0200
Message-ID: <20090416111436.296cdd12@hyperion.delvare>
References: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0A882F4D99BBF6449D58E61AAFD7EDD610424EB0-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Wen W" <wen.w.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wen,

On Wed, 15 Apr 2009 22:23:39 +0800, Wang, Wen W wrote:
> Hi all,
> 
> I'm Wen working on Linux driver for Intel MID platform. I have a couple of questions on submitting drivers into I2C tree. Can you please help on that?
> 
> I'm writing Linux I2C controller driver for Intel low power platform of MID. It has been accepted by Moblin and I'm planning to submit this driver to upstream.
> 
> 1. Is it ok if I submit this I2C driver with specific platform codes in driver?

I'm not sure exactly what you mean by "specific platform codes".
Probably the best is that you post your code and we'll see what code
this is.

> 2. How should I submit this I2C driver if it is dependent on another device driver which is also out of kernel tree?

You can always post your code early even if it can't be used
immediately. Just make sure you tell what the dependencies are.

After your code has been reviewed, when it is finally ready to be
merged, then of course we will ask you to first push all the
dependencies upstream, before we (most likely Ben) can push your code to
Linus.

> I can send the driver patch for your preview if it is ok.

Please do.

-- 
Jean Delvare
