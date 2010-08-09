From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [CORRECTED] I2C driver supporting Moorestown and Medfield platform
Date: Tue, 10 Aug 2010 08:58:01 +0900
Message-ID: <4C609609.6070307@renesas.com>
References: <20100803143431.23655.31975.stgit@localhost.localdomain>	<4C5F97AC.1020509@renesas.com> <20100809120743.05e22ef4@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100809120743.05e22ef4-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 8/9/2010 8:07 PM, Alan Cox wrote:
> There are various little differences along with the PCI, power
> management, timing and configuration side. I've also looked at the two

I'm interested in those little diffs.

> side by side and agreed with the original Intel authors that it seemed
> best to keep it as two drivers. Otherwise you drag a lot of PCI and PCI
> pm logic into a simpler driver that is used on non PCI platforms.

Got it, thanks. I'll have a look at the differences, first.
-- 
Shinya Kuribayashi
Renesas Electronics
