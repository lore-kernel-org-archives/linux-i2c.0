From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v1 v1 1/3] dt-bindings: i2c: add documentation for adding
 SiFive I2C driver
Date: Mon, 6 May 2019 15:19:19 +0200
Message-ID: <20190506131919.GC15291@lunn.ch>
References: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
 <1557147240-29551-2-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557147240-29551-2-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com, paul.walmsley@sifive.com, peter@korsgaard.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 06, 2019 at 06:23:58PM +0530, Sagar Shrikant Kadam wrote:
> Add DT binding for OpenCore's based i2c device as found in
> FU540 Chipset on HiFive Unleashed Platform (Rev A00).
> 
> The doc explains, how to add DT support for I2C devices.
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  .../devicetree/bindings/i2c/i2c-sifive.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sifive.txt

Hi Sagar

Please extend the existing i2c-ocores.txt file, not add a new file.

       Andrew
