From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 1/3] dt-bindings: i2c: extend existing opencore
 bindings.
Date: Tue, 21 May 2019 15:56:25 +0200
Message-ID: <20190521135625.GN22024@lunn.ch>
References: <1558445574-16471-1-git-send-email-sagar.kadam@sifive.com>
 <1558445574-16471-2-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1558445574-16471-2-git-send-email-sagar.kadam@sifive.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, peter@korsgaard.com, palmer@sifive.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-i2c@vger.kernel.org, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

>  Required properties:
> -- compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> +- compatible      : "opencores,i2c-ocores",
> +		    "aeroflexgaisler,i2cmst",
> +                    "sifive,fu540-c000-i2c","sifive,i2c0".
> +		    For Opencore based I2C IP block reimplemented in

It looks like there are some tabs vs space issues here.

   Andrew
