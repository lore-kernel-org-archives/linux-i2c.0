From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Mon, 19 Aug 2013 14:36:04 +0300
Message-ID: <20130819113604.GN4898@intel.com>
References: <20130711101330.GP4898@intel.com>
 <51DFB6C1.4040001@pobox.com>
 <20130712085140.GY4898@intel.com>
 <51E0E76B.1040304@pobox.com>
 <20130716111616.GA25835@ab42.lan>
 <51E6ACBE.7000509@pobox.com>
 <20130722131706.GA24081@ab42.lan>
 <51EFE550.1000507@pobox.com>
 <20130805093126.GE20936@ab42.lan>
 <520D8B30.9000602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <520D8B30.9000602@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shinya Kuribayashi <skuribay@pobox.com>
Cc: christian.ruppert@abilis.com, linux-i2c@vger.kernel.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 16, 2013 at 11:15:12AM +0900, Shinya Kuribayashi wrote:
> >Actually, the I2C specification clearly defines f_SCL;max (and thus
> >implies t_SCL;min), both in the tables and the timing diagrams. Why can
> >we ignore this constraint while having to meet all the others?
> 
> If we meet t_r, t_f, t_HIGH, t_LOW (and t_HIGH in this DW case),
> f_SCL;max will be met by itself.  And again, all I2C master and
> slave devices in the bus don't care about f_SCL; what they do care
> are t_f, t_r, t_HIGH, t_LOW, and so on.  That's why I'm saying
> f_SCL is pointless and has no value for HCNT/LCNT calculations.

One thing that comes to mind regarding the bus speed is that even if we
have all the minimal timing requirements met we still prefer resulting bus
speeds closer to 400kHz than 315.41kHz for the reasons that we get more
data transferred that way, no?
