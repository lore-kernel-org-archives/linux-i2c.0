From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt: snps,designware-i2c: Add clock bindings
 documentation
Date: Fri, 20 Jul 2018 10:19:57 -0600
Message-ID: <20180720161957.GA3486@rob-hp-laptop>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-2-git-send-email-phil.edworthy@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531731553-22979-2-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 16, 2018 at 09:59:12AM +0100, Phil Edworthy wrote:
> The driver requires an undocumented clock property, so detail it.
> Add documentation for a separate bus clock.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
