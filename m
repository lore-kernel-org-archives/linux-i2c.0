From: Stehle Vincent-B46079 <B46079@freescale.com>
Subject: RE: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 15:07:19 +0000
Message-ID: <F7C43F8B2814514CA05F3436BC68046EF379F0@039-SN2MPN1-011.039d.mgd.msft.net>
References: <20130625163902.GA2973@katana> <20130703143835.GD3929@ab42.lan>
 <201307031642.30380.arnd@arndb.de> <201307031644.09669.arnd@arndb.de>
 <20130703145918.GE3929@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130703145918.GE3929@ab42.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Ruppert <christian.ruppert@abilis.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robherring2@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

> From: Christian Ruppert [mailto:christian.ruppert@abilis.com]
(..)
> Although this doesn't explicitly state what the function returns to me
> this sounds more like the quotient is returned rather than the remainder?

Hi,

Yes div_u64() returns the quotient.

It is defined in linux/math64.h as:

  static inline u64 div_u64(u64 dividend, u32 divisor)
  {
          u32 remainder;
          return div_u64_rem(dividend, divisor, &remainder);
  }

The remainder is probably fully optimized out.

Best regards,

V.
