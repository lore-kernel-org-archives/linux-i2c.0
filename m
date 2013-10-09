From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c designware add support of I2C standard mode
Date: Wed, 9 Oct 2013 10:56:33 +0300
Message-ID: <20131009075632.GR3521@intel.com>
References: <20130828153429.GB7066@ab42.lan>
 <1381244455-3836-2-git-send-email-romainba@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381244455-3836-2-git-send-email-romainba@abilis.com>
Sender: linux-doc-owner@vger.kernel.org
To: Romain Baeriswyl <Romain.Baeriswyl@abilis.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, Vineet Gupta <vgupta@synopsys.com>, Christian Ruppert <christian.ruppert@abilis.com>, Chiau Ee Chew <chiau.ee.chew@intel.com>, Shinya Kuribayashi <skuribay@pobox.com>, Jean Delvare <khali@linux-fr.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Romain Baeriswyl <romainba@abilis.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 08, 2013 at 05:00:55PM +0200, Romain Baeriswyl wrote:
> Some legacy devices support ony I2C standard mode at 100kHz. 
> This patch allows to select the standard mode through the DTS 
> with the use of the existing clock-frequency parameter.
> 
> When clock-frequency parameter is not set, the fast mode is selected.
> Only when the parameter is set at 100000, the standard mode is selected.
> 
> Signed-off-by: Romain Baeriswyl <romainba@abilis.com>
> Reviewed-by: Christian Ruppert <christian.ruppert@abilis.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
