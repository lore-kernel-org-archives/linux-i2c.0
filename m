From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] treewide: remove redundent IS_ERR() before error code
 check
Date: Mon, 6 Jan 2020 21:15:21 -0800
Message-ID: <20200107051521.GF705@sol.localdomain>
References: <20200106045833.1725-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200106045833.1725-1-masahiroy@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <julia.lawall@lip6.fr>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 06, 2020 at 01:58:33PM +0900, Masahiro Yamada wrote:
> 'PTR_ERR(p) == -E*' is a stronger condition than IS_ERR(p).
> Hence, IS_ERR(p) is unneeded.
> 
> The semantic patch that generates this commit is as follows:
> 
> // <smpl>
> @@
> expression ptr;
> constant error_code;
> @@
> -IS_ERR(ptr) && (PTR_ERR(ptr) == - error_code)
> +PTR_ERR(ptr) == - error_code
> // </smpl>
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Any reason for not doing instead:

	ptr == ERR_PTR(-error_code)

?  To me it seems weird to use PTR_ERR() on non-error pointers.  I even had to
double check that it returns a 'long' and not an 'int'.  (If it returned an
'int', it wouldn't work...)

- Eric
