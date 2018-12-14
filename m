From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Date: Fri, 14 Dec 2018 17:27:48 +0100
Message-ID: <20181214162748.dt2ntmw5qn4j5q24@verge.net.au>
References: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 13, 2018 at 08:22:34PM +0000, Fabrizio Castro wrote:
> Similarly to R-Car E3, RZ/G2E doesn't come with automatic
> transmission registers, as such it is not considered compatible
> with the existing fallback bindings.
> 
> Add SoC specific binding compatibility to allow for later
> support for automatic transmission.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
