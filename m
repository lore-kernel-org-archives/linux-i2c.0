From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [i2c-tools PATCH v2] i2ctransfer: add new tool
Date: Mon, 6 Mar 2017 16:33:59 +0100
Message-ID: <CAMuHMdUO2-BCfdRUXghhZS7V=FoXNytesn8asCWH8nnpsnBxow@mail.gmail.com>
References: <20170306142931.10457-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170306142931.10457-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, Mar 6, 2017 at 3:29 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This tool allows to construct and concat multiple I2C messages into one
> single transfer. Its aim is to test I2C master controllers, and so there
> is no SMBus fallback.

Thanks for the tool!

> I've been missing such a tool a number of times now, so I finally got
> paround to writing it myself. As with all I2C tools, it can be dangerous,

around

Very dangerous, it inserts spurious "p" characters ;-)

> --- /dev/null
> +++ b/tools/i2ctransfer.8

> +.SH DESCRIPTION
> +.B i2ctransfer
> +is a program to create I2C messages and send them combined as one transfer.
> +For read messages, the contents of the received buffers are printed to stdout, one line per read message.
> +.br
> +Please note the difference between a
> +.I transfer
> +and a
> +.I message
> +here.
> +A transfer may consist of multiple messages and is started with a START condition and ends with a STOP condition as described in the I2C specification.

Funny, this is the other way around than on SPI (an SPI message consists
of multiple transfers).

> +.TP
> +.B {r|w}
> +specifies if the message is read or write
> +.TP
> +.B <length_of_message>
> +specifies the number of bytes read or written in this message.
> +It is parsed as an unsigned 16 bit integer, but note that the Linux might apply an additional upper limit (8192 as of v4.10).

s/the Linux/Linux/ (or the kernel, or i2c driver?)

> +.TP
> +.B [@address]
> +specifies the address of the chip to be accessed for this message, and is an integer.
> +If omitted, reuse the previous address.
> +Normally, addresses outside the range of 0x03-0x77 and addresses with a kernel driver attached to them will be blocked.

So 10-bit adressing needs -f?

> --- /dev/null
> +++ b/tools/i2ctransfer.c
> @@ -0,0 +1,347 @@

> +static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned flags)

unsigned int nmsgs?

> +{
> +       FILE *output = flags & PRINT_STDERR ? stderr : stdout;
> +       unsigned i;
> +       __u16 j;

unsigned int, too?

> +
> +       for (i = 0; i < nmsgs; i++) {
> +               int read = msgs[i].flags & I2C_M_RD;
> +               int print_buf = (read && (flags & PRINT_READ_BUF)) ||
> +                               (!read && (flags & PRINT_WRITE_BUF));
> +
> +               if (flags & PRINT_HEADER)
> +                       fprintf(output, "msg %u: addr 0x%02x, %s, len %u",
> +                               i, msgs[i].addr, read ? "read" : "write", msgs[i].len);
> +
> +               if (msgs[i].len && print_buf) {
> +                       if (flags & PRINT_HEADER)
> +                               fprintf(output, ", buf ");
> +                       for (j = 0; j < msgs[i].len - 1; j++)
> +                               fprintf(output, "0x%02x ", msgs[i].buf[j]);
> +                       /* Print final byte with newline */
> +                       fprintf(output, "0x%02x\n", msgs[i].buf[j]);
> +               } else if (flags & PRINT_HEADER) {
> +                       fprintf(output, "\n");
> +               }
> +       }
> +}
> +
> +static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)

unsigned int nmsgs?

> +{
> +       fprintf(stderr, "WARNING! This program can confuse your I2C bus, cause data loss and worse!\n");
> +       fprintf(stderr, "I will send the following messages to device file %s:\n", filename);
> +       print_msgs(msgs, nmsgs, PRINT_STDERR | PRINT_HEADER | PRINT_WRITE_BUF);
> +
> +       fprintf(stderr, "Continue? [y/N] ");
> +       fflush(stderr);
> +       if (!user_ack(0)) {
> +               fprintf(stderr, "Aborting on user request.\n");
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       char filename[20];
> +       int i2cbus, address = -1, file, arg_idx = 1, nmsgs = 0, nmsgs_sent, i;

unsigned int i?

> +       while (arg_idx < argc) {
> +               char *arg_ptr = argv[arg_idx];
> +               unsigned long len, raw_data;
> +               __u16 flags;

unsigned int flags?

> +               __u8 data, *buf;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
