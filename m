From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v10 4/8] i2c: thunderx: Add SMBUS alert support
Date: Tue, 23 Aug 2016 23:28:59 +0200
Message-ID: <20160823212859.GC28936@hardcore>
References: <cover.1465997603.git.jglauber@cavium.com>
 <4ba9512e145ee8d303393874a0033ed83ae33a8f.1465997604.git.jglauber@cavium.com>
 <20160823205724.GD20872@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160823205724.GD20872@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 23, 2016 at 10:57:25PM +0200, Wolfram Sang wrote:
> On Wed, Jun 15, 2016 at 03:51:30PM +0200, Jan Glauber wrote:
> > Add SMBUS alert interrupt support. For now only device tree is
> > supported for specifying the alert. In case of ACPI an error
> > is returned.
> > 
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> 
> What about 'select I2C_SMBUS' in Kconfig and skip all the ifdeffery?
> 

Wouldn't that prevent a distribution that has I2C_HELPER_AUTO set
from enabling the ThunderX i2c driver at all?

--Jan
