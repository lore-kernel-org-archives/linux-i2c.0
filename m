From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 6/6] i2c: core: Tidy up handling of init_irq
Date: Wed, 29 May 2019 10:44:22 +0300
Message-ID: <20190529074422.GW2781@lahna.fi.intel.com>
References: <20190528142900.24147-1-ckeepax@opensource.cirrus.com>
 <20190528142900.24147-6-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190528142900.24147-6-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, May 28, 2019 at 03:29:00PM +0100, Charles Keepax wrote:
> Only set init_irq during i2c_device_new and only handle client->irq on
> the probe/remove paths.
> 
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
