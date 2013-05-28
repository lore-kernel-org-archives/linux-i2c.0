From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] drivers/misc: at2x: use devm_kzalloc() to make
 cleanup paths simpler
Date: Tue, 28 May 2013 23:10:39 +0300
Message-ID: <CAHp75VdYxMovRMVQmspn14d+W2fZfSf-6CxODqqRBq1xvbU3yg@mail.gmail.com>
References: <1369767800-31895-1-git-send-email-n.a.balandin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369767800-31895-1-git-send-email-n.a.balandin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolay Balandin <n.a.balandin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexandre Pereira da Silva <aletes.xgr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nikolay Balandin <nbalandin-jFhMxQ4mL6a2X5qOxWx28w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks for updated version.
Please, find few comments below.

On Tue, May 28, 2013 at 10:03 PM, Nikolay Balandin
<n.a.balandin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Nikolay Balandin <nbalandin-jFhMxQ4mL6a2X5qOxWx28w@public.gmane.org>

Next time you may use --subject-prefix to specify the version of the
patch. This one in particular is "PATCH v2".

I'm pretty sure Greg or any maintainer will ask you to split your
patch to two: one per driver.

> Use devm_kzalloc() instead of kzalloc. Get rid of the "goto" statements
> and useless dev_dbg() calls when driver probe fails.

I think in the subject line is better to write something like
"at24: convert to use devm_kzalloc".
For at25 accordingly.

> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c

struct i2c_device_id *id)
>                 } else if (i2c_check_functionality(client->adapter,
>                                 I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
>                         use_smbus = I2C_SMBUS_BYTE_DATA;
> -               } else {
> -                       err = -EPFNOSUPPORT;
> -                       goto err_out;
> -               }
> +               } else
> +                       return -EPFNOSUPPORT;

It's good to keep the style here untouched, because it follows CodingStyle.
thus
} else {
 return ...
}

> @@ -596,11 +589,11 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                         at24->write_max = write_max;
>
>                         /* buffer (data + address at the beginning) */
> -                       at24->writebuf = kmalloc(write_max + 2, GFP_KERNEL);
> -                       if (!at24->writebuf) {
> -                               err = -ENOMEM;
> -                               goto err_struct;
> -                       }
> +                       at24->writebuf = devm_kzalloc(&client->dev,
> +                               write_max + 2, GFP_KERNEL);
> +

Redundant empty line

> +                       if (!at24->writebuf)
> +                               return -ENOMEM;
>                 } else {
>                         dev_warn(&client->dev,
>                                 "cannot write due to controller restrictions.");
> @@ -647,12 +640,6 @@ err_clients:
>         for (i = 1; i < num_addresses; i++)
>                 if (at24->client[i])
>                         i2c_unregister_device(at24->client[i]);
> -

No need to remove this empty line.

> @@ -666,9 +653,6 @@ static int at24_remove(struct i2c_client *client)
>
>         for (i = 1; i < at24->num_addresses; i++)
>                 i2c_unregister_device(at24->client[i]);
> -

Ditto.

--
With Best Regards,
Andy Shevchenko
