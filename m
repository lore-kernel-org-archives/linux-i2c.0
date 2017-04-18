From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] i2c: designware: do not show SDA hold time warning when
 not needed
Date: Tue, 18 Apr 2017 09:59:39 +0200
Message-ID: <20170418095939.68788787@free-electrons.com>
References: <1492203192-28025-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1492502087.24567.47.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1492502087.24567.47.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, 18 Apr 2017 10:54:47 +0300, Andy Shevchenko wrote:
> On Fri, 2017-04-14 at 22:53 +0200, Thomas Petazzoni wrote:
> > When the I2C controller IP block has a revision too old to be able to
> > configure the SDA hold time, the driver currently displays a
> > warning. However, it does so unconditionally, even if no SDA hold time
> > has been configured through the Device Tree. This causes useless
> > warnings when running the system, so only show the warning if a SDA
> > hold time was specified.  
> 
> As far as I understand the warning it would be better to keep it in
> either way, though you may shift it to debug level.
> 
> Wolfram, Jarkko, thoughts?

Why show a message when the user has not requested a custom SDA hold
time? Getting a warning about something you haven't requested seems
really odd.

I think it makes a lot more sense to keep it at the warning level
(because it's important to get this message if you configure a custom
SDA hold time), but only show it when appropriate.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
