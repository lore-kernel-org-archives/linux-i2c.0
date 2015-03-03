From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Tue, 03 Mar 2015 21:03:32 +0200
Message-ID: <1425409412.14897.157.camel@linux.intel.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
	 <54F5E120.3090705@alitech.com> <1425400650.17965.53.camel@synopsys.com>
	 <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com>
	 <20150303172145.GA7076@katana> <54F5F38D.5050309@alitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F5F38D.5050309@alitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Ruppert <christian.ruppert@alitech.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "christian.ruppert@abilis.com" <christian.ruppert@abilis.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-03-03 at 18:46 +0100, Christian Ruppert wrote:
> On 2015-03-03 18:21, Wolfram Sang wrote:
> > 
> >> which omit this type of messages completely. Andy's proposal of 
> >> centralising this looks like a very good solution here (and on
> >> top of that removes many useless strings from the kernel
> >> binary).
> > 
> > I am all for centralizing printouts. I recommended this at my ELCE
> > talk last year, too. However, you need to keep in mind that irqs
> > are sometimes optional and you don't want error messages for those
> > irqs. IMO worthwhile, but not a low hanging fruit...
> 
> There is a lot of truth in that. Thus the initial dev_dbg() suggestion
> to go half way. I still think that Andy's proposal (or a variation
> thereof to catch the optional irqs case) should be the ultimate goal
> but I agree that this is more than a quick patch and that it's
> probably way out of scope here.

Yes, I was thinking even about some wrapper on top of platform_get_irq()
since it seems there are no messaging done inside platform.c, though
devm_* functions usually have it.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
