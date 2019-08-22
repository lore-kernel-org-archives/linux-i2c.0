From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH] i2c: ocores: use request_any_context_irq() to register IRQ handler
Date: Thu, 22 Aug 2019 16:13:13 +0200
Message-ID: <875zmp5lvq.fsf@dell.be.48ers.dk>
References: <20190822132132.16557-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822132132.16557-1-federico.vaga@cern.ch> (Federico Vaga's
        message of "Thu, 22 Aug 2019 15:21:32 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Federico" == Federico Vaga <federico.vaga@cern.ch> writes:

 > The i2c-ocores device is an HDL component that get instantiated in FPGA.
 > The software stack used to drive an FPGA can be very different, and the
 > i2c-ocore ip-core must work in different context. With respect to this
 > patch the IRQ controller behind this device, and its driver, can have
 > different implementations (nested threads). For this reason, it is safer
 > to use `request_any_context_irq()` to avoid errors at probe time.

 > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
