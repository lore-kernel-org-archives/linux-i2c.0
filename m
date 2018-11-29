From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 01/25] nvmem: add new config option
Date: Thu, 29 Nov 2018 15:30:19 +0100
Message-ID: <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com>
References: <20181113140133.17385-1-brgl@bgdev.pl> <20181113140133.17385-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113140133.17385-2-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c <linux-i2c@vger.kernel.org>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

wt., 13 lis 2018 o 15:01 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want to add nvmem support for MTD. TI DaVinci is the first platform
> that will be using it, but only in non-DT mode. In order not to
> introduce any new interface to supporting of which we would have to
> commit - add a new config option that tells nvmem not to use the DT
> node of the parent device.
>
> This way we won't be creating nvmem devices corresponding with MTD
> partitions defined in device tree. By default MTD will set this new
> field to true.
>
> Once a set of bindings for MTD nvmem cells is agreed upon, we'll be
> able to remove this option.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/nvmem/core.c           | 3 ++-
>  include/linux/nvmem-provider.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9b18ce90f907..ac7971e8154e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -604,7 +604,8 @@ struct nvmem_device *nvmem_register(const struct nvme=
m_config *config)
>         nvmem->priv =3D config->priv;
>         nvmem->reg_read =3D config->reg_read;
>         nvmem->reg_write =3D config->reg_write;
> -       nvmem->dev.of_node =3D config->dev->of_node;
> +       if (!config->no_of_node)
> +               nvmem->dev.of_node =3D config->dev->of_node;
>
>         if (config->id =3D=3D -1 && config->name) {
>                 dev_set_name(&nvmem->dev, "%s", config->name);
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provide=
r.h
> index 1e3283c2af77..e53545e9852b 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -30,6 +30,7 @@ typedef int (*nvmem_reg_write_t)(void *priv, unsigned i=
nt offset,
>   * @ncells:    Number of elements in cells.
>   * @read_only: Device is read-only.
>   * @root_only: Device is accessibly to root only.
> + * @no_of_node:        Device should not use the parent's of_node even i=
f it's !NULL.
>   * @reg_read:  Callback to read data.
>   * @reg_write: Callback to write data.
>   * @size:      Device size.
> @@ -53,6 +54,7 @@ struct nvmem_config {
>         int                     ncells;
>         bool                    read_only;
>         bool                    root_only;
> +       bool                    no_of_node;
>         nvmem_reg_read_t        reg_read;
>         nvmem_reg_write_t       reg_write;
>         int     size;
> --
> 2.19.1
>

Hi Srinivas,

if there are no objections - can you Ack this patch for Greg to pick
up into char-misc?

Bart
