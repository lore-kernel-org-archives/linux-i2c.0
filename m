From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] i2c: ocores: use request_any_context_irq() to register
 IRQ handler
Date: Thu, 22 Aug 2019 15:48:41 +0200
Message-ID: <20190822134841.GG13020@lunn.ch>
References: <20190822132132.16557-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822132132.16557-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 22, 2019 at 03:21:32PM +0200, Federico Vaga wrote:
> The i2c-ocores device is an HDL component that get instantiated in FPGA.
> The software stack used to drive an FPGA can be very different, and the
> i2c-ocore ip-core must work in different context. With respect to this
> patch the IRQ controller behind this device, and its driver, can have
> different implementations (nested threads). For this reason, it is safer
> to use `request_any_context_irq()` to avoid errors at probe time.
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
