From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [3/3,v2] i2c-gpio: add devicetree support
Date: Mon, 31 Jan 2011 14:29:57 -0700
Message-ID: <AANLkTimoaJKy-WTTHmRXFMmM6=e7uvzhjwRcDtNqGAPj@mail.gmail.com>
References: <1296487551-30938-3-git-send-email-thomas@wytron.com.tw>
	<of-i2c-doc@mdm.bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <of-i2c-doc-kM9DGJe42AJBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Milton Miller <miltonm-ogEGBHC/i9Y@public.gmane.org>
Cc: nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 31, 2011 at 2:14 PM, Milton Miller <miltonm-ogEGBHC/i9Y@public.gmane.org> wrote:
> On Mon, 31 Jan 2011 about 15:25:51 -0000, Thomas Chou wrote:
>
>> This patch is based on an earlier patch from Albert Herranz,
>> http://git.infradead.org/users/herraa1/gc-linux-2.6.git/commit/
>> 9854eb78607c641ab5ae85bcbe3c9d14ac113733
>>
>> The dts binding is modified as Grant suggested. The of probing
>> is merged inline instead of a separate file. It uses the newer
>> of gpio probe.
>
>> @@ -172,6 +227,8 @@ err_request_sda:
>> =A0err_alloc_bit_data:
>> =A0 =A0 =A0 kfree(adap);
>> =A0err_alloc_adap:
>> + =A0 =A0 if (!pdev->dev.platform_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata);
>
> This looks better with the code move to the function above, but
> I don't like the condition on this free here ...
>
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> @@ -179,23 +236,33 @@ static int __devexit i2c_gpio_remove(struct platfo=
rm_device *pdev)
>> =A0{
>> =A0 =A0 =A0 struct i2c_gpio_platform_data *pdata;
>> =A0 =A0 =A0 struct i2c_adapter *adap;
>> + =A0 =A0 struct i2c_algo_bit_data *bit_data;
>>
>> =A0 =A0 =A0 adap =3D platform_get_drvdata(pdev);
>> - =A0 =A0 pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 bit_data =3D adap->algo_data;
>> + =A0 =A0 pdata =3D bit_data->data;
>>
>> =A0 =A0 =A0 i2c_del_adapter(adap);
>> =A0 =A0 =A0 gpio_free(pdata->scl_pin);
>> =A0 =A0 =A0 gpio_free(pdata->sda_pin);
>> =A0 =A0 =A0 kfree(adap->algo_data);
>> =A0 =A0 =A0 kfree(adap);
>> + =A0 =A0 if (!pdev->dev.platform_data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata);
>
> and especially here ... it seems unrelated.
>
> Looking at devices/base/platform.c, how about just allocating the
> initial platform data struct on the stack in i2c_gpio_of_probe
> and then calling platform_device_add_data? =A0That way the pdev
> is responsible for freeing the data.

No, *do not* use platform_device_add_data().  It stores the pointer in
pdev->dev.platform_data which gets freed when the last reference to
the device is dropped (it gets removed from the bus).  Thomas wants
something that gets freed when the driver is unbound.

Driver code must never modify the pdev->dev.platform_data pointer.
Doing so causes all kinds of lifecycle ambiguity which messes up
driver unbinding/rebinding and module load/unload.  When a driver
needs a modifiable copy of platform data, then it must include a copy
of the platform_data in the driver private data structure.  It should
be straight forward to refactor this driver to do so.

g.
