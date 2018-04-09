From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 10/10] dt-bindings: gpio: Add bindings for Cadence I3C
 gpio expander
Date: Mon, 9 Apr 2018 15:26:10 -0500
Message-ID: <20180409202610.2ckwi4ekswiaumym@rob-hp-laptop>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-11-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-11-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeau>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 30, 2018 at 09:47:51AM +0200, Boris Brezillon wrote:
> Document the Cadence I3C gpio expander bindings.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v4:
> - Use GPIO_ and IRQ_TYPE_ macros instead of raw numbers
> - Fix the unit-address in the example
> ---
>  .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

Reviewed-by: Rob Herring <robh@kernel.org>
