From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 04/10] dt-bindings: i3c: Document core bindings
Date: Mon, 9 Apr 2018 15:24:26 -0500
Message-ID: <20180409202426.grl62ydysfse27ly@rob-hp-laptop>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-5-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-5-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeau>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 30, 2018 at 09:47:45AM +0200, Boris Brezillon wrote:
> A new I3C subsystem has been added and a generic description has been
> created to represent the I3C bus and the devices connected on it.
> 
> Document this generic representation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v4:
> - Clarify the fact that static address == I3C address and dynamic
>   address == I3C address
> - Use i2c-scl-hz in the example
> 
> Changes in v3:
> - Rename {i2c,i3c}-scl-frequency DT prop into {i2c,i3c}-scl-hz
> - Rework the way we expose the provisional ID and LVR information
> - Rename dynamic-address into assigned-address
> - Enforce the I3C master node name
> 
> Changes in v2:
> - Define how to describe I3C devices in the DT and when it should be
>   used. Note that the parsing of I3C devices is not yet implemented in
>   the framework. Will be added when someone really needs it.
> ---
>  Documentation/devicetree/bindings/i3c/i3c.txt | 140 ++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt

Reviewed-by: Rob Herring <robh@kernel.org>
