From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v0 4/4] i2c: meson: Use complete() instead of complete_all()
Date: Tue, 16 Aug 2016 08:12:45 -0500
Message-ID: <m2shu497si.fsf@baylibre.com>
References: <1470225791-16613-1-git-send-email-wagi@monom.org>
	<1470225791-16613-5-git-send-email-wagi@monom.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470225791-16613-5-git-send-email-wagi@monom.org> (Daniel
	Wagner's message of "Wed, 3 Aug 2016 14:03:11 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Tim Kryger <tim.kryger@linaro.org>, Ray Jui <rjui@broadcom.com>, Daniel Wagner <daniel.wagner@bmw-carit.de>, linux-kernel@vger.kernel.org, Beniamino Galvani <b.galvani@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Daniel Wagner <wagi@monom.org> writes:

> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>
> There is only one waiter for the completion, therefore there
> is no need to use complete_all(). Let's make that clear by
> using complete() instead of complete_all().
>
> The usage pattern of the completion is:
>
> meson_i2c_xfer_msg()
>   reinit_completion()
>   ...
>   /* Start the transfer */
>   ...
>   wait_for_completion_timeout()
>
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>

Acked-by: Kevin Hilman <khilman@baylibre.com>
