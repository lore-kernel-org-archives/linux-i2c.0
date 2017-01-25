From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] i2c: core: helper function to detect slave mode
Date: Wed, 25 Jan 2017 22:50:09 +0200
Message-ID: <1485377409.2133.339.camel@linux.intel.com>
References: <58edd25a0fbe50b6d5abef14b7e46c63a1e06830.1484663257.git.lolivei@synopsys.com>
         <20170125204537.i66nykln4fkxqryy@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170125204537.i66nykln4fkxqryy@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vz@mleia.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Wed, 2017-01-25 at 21:45 +0100, Wolfram Sang wrote:
> > + * i2c_slave_mode_detect - detect operation mode
> 
> I'd rather name it 'i2c_detect_slave_mode'

When I proposed that I kept in ming `git grep -n i2c_slave`.

> The code looks good to me, so we are close to go!

Thumb up!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
