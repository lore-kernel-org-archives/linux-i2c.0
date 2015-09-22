From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Mon, 21 Sep 2015 20:30:29 -0500
Message-ID: <1442885429.19102.210.camel@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150922012403.GA1535@svinekod>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com
Cc: "corbet@lwn.net" <corbet@lwn.net>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, Zhiqiang Hou <B48286@freescale.com>, Will Deacon <Will.Deacon@arm.com>, "wim@iguana.be" <wim@iguana.be>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>, "leoli@freescale.com" <leoli@freescale.com>, "Wenbin.Song@freescale.com" <Wenbin.Song@freescale.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shaohui.Xie@freesc
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-09-22 at 02:24 +0100, Mark Rutland wrote:
> > +       clockgen:  clocking@1ee1000{
> > +               compatible = "fsl,ls1043a-clockgen";
> > +               reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +               #clock-cells = <2>;
> > +               clocks = <&sysclk>;
> > +               sysclk: sysclk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <100000000>;
> > +                       clock-output-names = "sysclk";
> > +               };
> > +       };
> 
> Why does this fixed clock live under the clockgen? It should live directly
> under the root node.

I think this is copy-and-paste from some legacy PPC stuff.  There's no reason 
anymore to put sysclk under clockgen.

-Scott
