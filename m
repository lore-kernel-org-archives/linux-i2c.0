From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: Intel BayTrail PMIC I2C bus support
Date: Tue, 16 Sep 2014 13:58:02 +0300
Message-ID: <20140916105802.GE10854@lahna.fi.intel.com>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
 <20140916094449.GZ10854@lahna.fi.intel.com>
 <20140916035327.4d3d5555@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140916035327.4d3d5555@ultegra>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "David E. Box" <david.e.box@linux.intel.com>, wsa@the-dreams.de, jdelvare@suse.de, arnd@arndb.de, dianders@chromium.org, sjg@chromium.org, laurent.pinchart+renesas@ideasonboard.com, u.kleine-koenig@pengutronix.de, boris.brezillon@free-electrons.com, maxime.coquelin@st.com, max.schwarz@online.de, schwidefsky@de.ibm.com, iivanov@mm-sol.com, soren.brinkmann@xilinx.com, bjorn.andersson@sonymobile.com, andrew@lunn.ch, skuribay@pobox.com, christian.ruppert@abilis.com, Romain.Baeriswyl@abilis.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 16, 2014 at 03:53:27AM -0700, Jacob Pan wrote:
> On Tue, 16 Sep 2014 12:44:49 +0300
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > Is this because we need to access the PMIC from host as well? I mean
> > from some PMIC driver (which driver btw)?
> > 
> This is used by the X-Powers PMIC.
> https://lkml.org/lkml/2014/9/11/1016

Ok, thanks Jacob. So just returning -ENODEV is out of the question :-(
