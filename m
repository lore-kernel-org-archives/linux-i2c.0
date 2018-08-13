From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
Date: Mon, 13 Aug 2018 08:15:35 -0600
Message-ID: <CAL_JsqLMxyBtZBtzZOVN7Dx3guD7vgrGwH6E05P3d+ZFW7FOcg@mail.gmail.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-3-git-send-email-soares@synopsys.com> <20180725195733.GA14450@rob-hp-laptop>
 <c00cb815-ae82-312a-213b-145537a294bd@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c00cb815-ae82-312a-213b-145537a294bd@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>Mark Rutland <m>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 8, 2018 at 10:59 AM vitor <Vitor.Soares@synopsys.com> wrote:
>
> Hi Rob,
>
>
> On 25-07-2018 20:57, Rob Herring wrote:
> > On Fri, Jul 20, 2018 at 09:57:51PM +0100, Vitor soares wrote:
> >> This patch document Synopsys DesignWare I3C master DT bindings.
> >>
> >> Signed-off-by: Vitor soares <soares@synopsys.com>
> >> ---
> >>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 43 ++++++++++++++++++++++
> >>   1 file changed, 43 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >> new file mode 100644
> >> index 0000000..7f5c8b0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >> @@ -0,0 +1,43 @@
> >> +Bindings for Synopsys DesignWare I3C master block
> >> +=================================================
> >> +
> >> +Required properties:
> >> +--------------------
> >> +- compatible: shall be "snps,dw-i3c-master"
> > Only one version and no version number?
> >
> > ... and an SoC specific compatible string.
>
> I'm not understanding. Can you explain?

Add the above line to the description. Experience shows that only an
IP vendor compatible string is not sufficient. SoC vendors integrate
different versions, configure the IP differently and/or integrate it
differently.

Rob
