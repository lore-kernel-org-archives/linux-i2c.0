From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v0 2/4] i2c: bcm-kona: Use complete() instead of
 complete_all()
Date: Wed, 3 Aug 2016 09:38:11 -0700
Message-ID: <f47779be-5e1e-cbf2-b590-fdd9a0e80917@broadcom.com>
References: <1470225791-16613-1-git-send-email-wagi@monom.org>
 <1470225791-16613-3-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470225791-16613-3-git-send-email-wagi@monom.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Wagner <wagi@monom.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Tim Kryger <tim.kryger@linaro.org>, Ray Jui <rjui@broadcom.com>, Daniel Wagner <daniel.wagner@bmw-carit.de>, linux-kernel@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On 8/3/2016 5:03 AM, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>
> There is only one waiter for the completion, therefore there
> is no need to use complete_all(). Let's make that clear by
> using complete() instead of complete_all().
>
> The usage pattern of the completion is:
>
> bcm_kona_send_i2c_cmd()
>   reinit_completion()
>   ...
>   bcm_kona_i2c_send_cmd_to_ctrl()
>   ...
>   wait_for_completion_timeout()
>
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> ---
>  drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
> index ac9f476..f987432 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -229,7 +229,7 @@ static irqreturn_t bcm_kona_i2c_isr(int irq, void *devid)
>  		       dev->base + TXFCR_OFFSET);
>
>  	writel(status & ~ISR_RESERVED_MASK, dev->base + ISR_OFFSET);
> -	complete_all(&dev->done);
> +	complete(&dev->done);
>
>  	return IRQ_HANDLED;
>  }
>

This change looks good me! Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>
