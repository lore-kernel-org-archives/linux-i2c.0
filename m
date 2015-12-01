From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 0/2] ACPI: Add irq_type to gpio interrupt
Date: Tue, 1 Dec 2015 13:21:27 +0200
Message-ID: <20151201112127.GA1593@lahna.fi.intel.com>
References: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448923673-2582-1-git-send-email-christophe-h.ricard@st.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Christophe Ricard <christophe.ricard@gmail.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 30, 2015 at 11:47:51PM +0100, Christophe Ricard wrote:
> ACPI probing method does not retrieve irq_type from a gpio interrupt declared
> with GpioInt as it is done with devicetree probing. In other terms, irq_get_trigger_type
> will always send back 0.

Is this real problem you are solving here?

Also where does the device tree version set triggering flags for a GPIO
irq?
