From: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [PATCH V3 2/3] i2c-nomadik: turn the platform driver to an
 amba driver
Date: Thu, 14 Jun 2012 10:17:58 +0200
Message-ID: <20120614081758.GA19648@mail.gnudd.com>
References: <201206140804.39083.arnd@arndb.de>
  <cover.1339447570.git.rubini@gnudd.com>
 <4a198618063924b68182279ffd56c335d621f542.1339447570.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201206140804.39083.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, giancarlo.asnaghi@st.com, linux@arm.linux.org.uk, linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com, w.sang@pengutronix.de, khali@linux-fr.org, linux-i2c@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, lee.jones@linaro.org, alan@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

> You change only one half of ux500 here: the part where the device
> gets defined statically, but not not the definition in the
> device-tree.

Yes, I'm aware. That's why I added Lee Jones as Cc:, on Linusw's
suggestion.  Lee told me to go ahead and he'll fix the DT stuff.
Lee?

thanks
/alessandro
