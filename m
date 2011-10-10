From: Przemyslaw Wegrzyn <pwegrzyn-qaBtZ/OuEkOiu113P13oHA@public.gmane.org>
Subject: Re: Finding particular I2C adapter?
Date: Mon, 10 Oct 2011 14:20:33 +0200
Message-ID: <4E92E311.8080402@codepainters.com>
References: <4E8EF3DC.7060704@codepainters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E8EF3DC.7060704-qaBtZ/OuEkOiu113P13oHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/07/2011 02:43 PM, Przemyslaw Wegrzyn wrote:
> Ideally, I'd like to have a sort of wrapper module that will find the
> proper i2c_adapter and instantiate my i2c_client explicitly. Yet I know
> that iterating i2c adapters is discouraged at least (actually, is there
> any API now allowing for this? calling i2c_get_adapter with successive
> numbers is clearly a hack).
Answering my own question - there's i2c_for_each_dev() that I've
overlooked before. Still a hack, anyway.

--
Przemek
