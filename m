From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date: Wed, 19 Sep 2018 11:25:04 -0700
Message-ID: <153738150448.119890.13258586980997802695@swboyd.mtv.corp.google.com>
References: <20180918194126.138455-1-swboyd@chromium.org> <20180918221646.GA970@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918221646.GA970@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Wolfram Sang (2018-09-18 15:16:46)
> =

> > This fixes a problem where the kernel oopses cleaning pages for a buffer
> > that's mapped into the vmalloc space. The pages are returned from
> > request_firmware() and passed down directly to the i2c master to write
> > to the i2c touchscreen device. Mapping vmalloc buffers with
> > dma_map_single() won't work reliably, causing an oops like below:
> =

> Exactly the reason why I implemented I2C_M_DMA_SAFE. Did you also notice
> the helper i2c_get_dma_safe_msg_buf() which you maybe could use for
> len > 32?
> =


Yes I noticed that after sending the patch, thanks for pointing it out.

But now when I try to use it I'm not exicted when the buffer is bounced
but we fail to map the buffer with the DMA APIs. For an I2C_M_RD
message, presumably we would call i2c_release_dma_safe_msg_buf() in this
error case, but that will cause the original buffer to be copied over
which seems wasteful to do, but I guess it's OK. I suppose we could have
another function like:

void i2c_release_dma_safe_msg_buf_on_err(struct i2c_msg *msg, u8 *buf)
{
        if (!buf || buf =3D=3D msg->buf)
                return;

        kfree(buf);
}

so that we don't copy over the buffer on failure and still properly free
the buffer that we setup. Or we can pass an argument to
i2c_release_dma_safe_msg_buf() to indicate if we should do the memcpy or
not? Removing the I2C_M_RD flag from the message on failure doesn't
sound like a good idea.

Either way, I can resend the patch with the releasing and duplicate
memcpy and we can discuss this minor optimization.
