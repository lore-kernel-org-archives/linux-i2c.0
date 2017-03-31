From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Fri, 31 Mar 2017 13:01:55 +0300
Message-ID: <1490954515.708.72.camel@linux.intel.com>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
         <20170323204747.w2nxxrpjwypiygwb@ninjato>
         <20170330155233.dfnqe7d2xkr32zlo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170330155233.dfnqe7d2xkr32zlo@ninjato>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-03-30 at 17:52 +0200, Wolfram Sang wrote:
> On Thu, Mar 23, 2017 at 09:47:47PM +0100, Wolfram Sang wrote:
> > On Fri, Mar 10, 2017 at 04:58:35PM +0300, Viktor Krasnov wrote:

> > > Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> > > Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> > > Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>


A bit of offtopic here, but I have noticed kontron.com address in SoB
lines.

I would like to know if Kontron will follow ACPI spec when assembling
firmwares for its board [1]?

Table name LPW8 for SSDT is not allowed by spec and can't be just
decompiled without hacking either table or decompiler.

[1] http://www.kontron.com/products/boards-and-standard-form-factors/sma
rc/smarc-sxbt.html

P.S. We may continue privately to not contaminate mailing list with
unnecessary noise.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
