From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH] i2c-eg20t: use i2c_add_numbered_adapter to get a fixed
 bus number
Date: Thu, 12 Jan 2012 13:39:07 +0530
Message-ID: <4F0E9523.1040709@st.com>
References: <1326353882-3158-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326353882-3158-1-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 1/12/2012 1:08 PM, Feng Tang wrote:
> For EG20T and ML7213 IOH, the i2c controller numbers are fixed, using
> fixed bus number will make it much easier for platform code to use
> i2c_register_board_info() to register i2c devices.
>
> Signed-off-by: Feng Tang<feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-eg20t.c |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
> index 18936ac..079435b 100644
> --- a/drivers/i2c/busses/i2c-eg20t.c
> +++ b/drivers/i2c/busses/i2c-eg20t.c
> @@ -918,7 +918,9 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
>   		pch_adap->dev.parent =&pdev->dev;
>
>   		pch_i2c_init(&adap_info->pch_data[i]);
> -		ret = i2c_add_adapter(pch_adap);
> +
> +		pch_adap->nr = i;
> +		ret = i2c_add_numbered_adapter(pch_adap);
>   		if (ret) {
>   			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
>   			goto err_add_adapter;

Reviewd By: Rajeev Kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
