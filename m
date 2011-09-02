From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Fri, 2 Sep 2011 15:21:04 +0200
Message-ID: <20110902152104.1cc3e2c6@endymion.delvare>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
	<CAEdQ38E6qqVAKC1MkAWto5yeU9N2uoyGY1Y5431kNUNL_yc8EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEdQ38E6qqVAKC1MkAWto5yeU9N2uoyGY1Y5431kNUNL_yc8EA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 24 Aug 2011 11:36:48 -0400, Matt Turner wrote:
> On Thu, Aug 18, 2011 at 7:43 PM, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Signed-off-by: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Maciej W. Rozycki <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> 
> Do you want to take this patch, or should Ralf through his tree?

My tree is fine, unless Ralf has a specific reason to pick it. Just
give me a couple hours to review the patch.

-- 
Jean Delvare
