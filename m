From: Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: About one i2c failure issue after system reset
Date: Mon, 21 Nov 2011 15:49:49 +0530
Message-ID: <4ECA25C5.3010205@st.com>
References: <CAFQ4atSRapXvhBnm=nH__zz2U=XRjxN4GK-JsXT=AEcKybANZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFQ4atSRapXvhBnm=nH__zz2U=XRjxN4GK-JsXT=AEcKybANZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Hui <jason.hui-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Jason

On 11/21/2011 1:05 PM, Jason Hui wrote:
> Hi, Ben, Jean,
>
> I have one issue about the i2c failure: there will be on-going i2c
> transfer while system get reset.
> At the time when the reset happens, the slave may pull the SDA to
> LOW.After reset, the i2c master may reset, but
> the slave may still pull the SDA to LOW since there is no reset pin
> for the slave device to do i2c reset, thus
> result in the further i2c access failure forever unless we completely
> power off the system by pulling out
> the battery.
>
This is not the only solution for this. Master can accomplishes error 
recovery by clocking Clock until Data is high and then issuing a Start 
followed by a Stop.

Best Regards
Rajeev
...

> I know we have the shutdown member function, but as I know there is
> very less i2c master has implemented this
> function correctly. I think we need take seriously about this issue,
> do you have any comments? Thanks,
>
>
> Jason Liu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
