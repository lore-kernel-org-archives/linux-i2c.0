From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] ARM: Tegra: i2c driver
Date: Tue, 21 Jun 2011 16:34:46 -0600
Message-ID: <BANLkTi=S8ddKE_ahHXDhW75hhPohqS+gRQ@mail.gmail.com>
References: <20110621002318.8086.48367.stgit@riker> <BANLkTi=aaSnT-incv3FhOZ0Yp8CtYf31mA@mail.gmail.com>
 <BANLkTinJOf+L1kE9gQ99=uA_HK2_+Hts-AyAD8QuWNAa-rZ9+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTinJOf+L1kE9gQ99=uA_HK2_+Hts-AyAD8QuWNAa-rZ9+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, kradtke-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 21, 2011 at 4:11 PM, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
> On Mon, Jun 20, 2011 at 9:59 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> On Mon, Jun 20, 2011 at 6:23 PM, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>>> This patch modifies the tegra i2c driver so that it can be initiailized
>>> using the device tree along with the devices connected to the i2c bus.
>>>
>>> Signed-off-by: John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>
>> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>
> Acked-by: OIof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
>
>
> (with the same suggestion to change subject as Stephen/Grant discussed
> later in the thread).

Ben, would you like a new patch with the new subject line, or will you
fix it up when you merge it?

g.
