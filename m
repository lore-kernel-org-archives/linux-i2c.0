From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] treewide: remove redundent IS_ERR() before error code check
Date: Tue, 7 Jan 2020 10:52:57 +0100
Message-ID: <CAJZ5v0jBEq+GiTP8V4ZzQvR9qbSBdEz_P8EZNX7yNZMzTjB86Q@mail.gmail.com>
References: <20200106045833.1725-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200106045833.1725-1-masahiroy@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <julia.lawall@lip6.fr>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, linux-crypto@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, netdev <netdev@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 6, 2020 at 6:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
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
> ---

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the acpi/scan.c change, but there seems to be a typo in the subject:

s/redundent/redundant/
