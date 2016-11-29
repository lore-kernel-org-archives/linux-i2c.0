From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH V1] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Tue, 29 Nov 2016 11:26:31 +0200
Message-ID: <20161129092631.GQ1459@lahna.fi.intel.com>
References: <1480390327-24562-1-git-send-email-tnhuynh@apm.com>
 <20161129090431.GM1459@lahna.fi.intel.com>
 <CANQ9TuBLeiXCcZANic7K+JrwPSpgZ8Qxm8kPBrwvK0h1y7bOuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANQ9TuBLeiXCcZANic7K+JrwPSpgZ8Qxm8kPBrwvK0h1y7bOuA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 29, 2016 at 04:15:13PM +0700, Tin Huynh wrote:
>    Yes , My IP core supports 16 bytes size only . Should we get this
>    parameter from ACPI table instead of 32 ?

What if we set the default 32 from ACPI as currently but then read the
value from hardware as well and pick the smaller one of the two?
