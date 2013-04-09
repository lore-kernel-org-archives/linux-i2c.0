From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [4/7] i2c-designware: use dynamic adapter numbering on Lynxpoint
Date: Tue, 9 Apr 2013 12:23:19 +0300
Message-ID: <20130409092319.GF21818@intel.com>
References: <1363867800-23861-4-git-send-email-mika.westerberg@linux.intel.com>
 <20130409090605.GC28509@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130409090605.GC28509@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 09, 2013 at 11:06:05AM +0200, Wolfram Sang wrote:
> On Thu, Mar 21, 2013 at 02:09:57AM -0000, Mika Westerberg wrote:
> > It is not good idea to mix static and dynamic I2C adapter numbering. In
> > this particular case on Lynxpoint we had graphics I2C adapter which took
> > the first numbers preventing the designware I2C driver from using the
> > adapter numbers it preferred.
> > 
> > Fix this by switching to use dynamic adapter numbering on Intel Lynxpoint.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I am fearing regressions here if the bus numbering changes.

There are no users for this dynamic numbering yet since it was introduced
with the Lynxpoint support.
