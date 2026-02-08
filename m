Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A313957E;
	Sun,  8 Feb 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559034; cv=pass; b=MxVVy9mfH2kd4ucpF8/eLwCPmucfjKwMh8azuxkBOomfY7N8R/X+wNM9eDxaGlIFxlGvgxbTSz7WuxRavvWx0MAKdORW8Sn5r6iy2urNeiGvGkmK2QUzn7+l1YosqN4L5yMGEPfnYHr8NOd/AmoevIuuaHIAW5CRdYo8HzIOKxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559034; c=relaxed/simple;
	bh=2aqg+v+uPg2CrfFBvLIh8hbrwuy9d5oEUnUfngpB/nE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M+W3CN1Ol56jL5D15rEwGAhjDnXqgBsJoVF4FArVxLPG4GFjQfoBGzUiaHNzKol1YjClIKon8uTvCRsgz4uC4mq6TX00ZOoHqW6Sk5b+z6KQy0JerbrJqUmoQYfYLQERm0GFwrV9pb/kZsbpXSW4dB0RZlQ6TbR922n6NzXhi6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XCmvQzRX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XCmvQzRX"
ARC-Seal: i=1; a=rsa-sha256; t=1770559000; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JD+0ucMyq2fSurQdg3s79C9VSWJNTWEm8CHe+pu5e8Nzq7y0L+Qb5iytr9YBCJL38dLTanugeCbzuGE1qin1pcwfuEPVjNGB/lXhLOj4u7K+4zWnn0sU88Z+y2UZp3To/fohg3Ru9663aAS2R8zAnw8J1zyzVHoCfkQK8gj5VHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770559000; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D3Ks0nXNLCBbay3x5s9T/occqM3ti1EHzUn6BOU1osY=; 
	b=TfORmAGnNLLuzzRgDZK+mJxAIIj53gBIChdCpSbsVxqs0d+ImiJ+Gf//BeNZ8MfccOa5aGIr8BnVfIYuW2nv3KqqnAy5EdJsxcj+c6EIss4xecjIA6CR9m8PHW9yN8EiTGrtwfmLPio8eyASS9QkZhIc+KVUcpk+gC18WS+VgdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770559000;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=D3Ks0nXNLCBbay3x5s9T/occqM3ti1EHzUn6BOU1osY=;
	b=XCmvQzRXuF/U5TonyG6kPYmRbepfn+vJAY0UMTWW6yOMm21vHs1Nr6Ya+3XO1dBJ
	dgdUhqg8zpzt31xuLfcIDU3cNTvo94H7nnPReGvoqP/JHKq1msW7iCF2NamGICTQ9Dd
	W1spJDTsIxaRu6wfdaXrDX9zNyVyVfSZukHBiSRE=
Received: by mx.zohomail.com with SMTPS id 1770558997471764.0545265752776;
	Sun, 8 Feb 2026 05:56:37 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/5] rust: bits: add define_flags macro
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260131-i2c-adapter-v1-2-5a436e34cd1a@gmail.com>
Date: Sun, 8 Feb 2026 10:56:22 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-i2c@vger.kernel.org,
 markus.probst@posteo.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC15901F-F607-40E8-928F-5EA7F364B0CE@collabora.com>
References: <20260131-i2c-adapter-v1-0-5a436e34cd1a@gmail.com>
 <20260131-i2c-adapter-v1-2-5a436e34cd1a@gmail.com>
To: igor.korotin.linux@gmail.com
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Igor,

> On 31 Jan 2026, at 11:12, Igor Korotin via B4 Relay =
<devnull+igor.korotin.linux.gmail.com@kernel.org> wrote:
>=20
> From: Igor Korotin <igor.korotin.linux@gmail.com>
>=20
> introduce define_flags macro that incorporates BitOr BitAnd and Not
> implementations.
>=20
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
> rust/kernel/bits.rs | 57 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 57 insertions(+)
>=20
> diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
> index 553d50265883..6750aef18708 100644
> --- a/rust/kernel/bits.rs
> +++ b/rust/kernel/bits.rs
> @@ -201,3 +201,60 @@ pub const fn [<genmask_ $ty>](range: =
RangeInclusive<u32>) -> $ty {
>     /// assert_eq!(genmask_u8(0..=3D7), u8::MAX);
>     /// ```
> );
> +
> +/// defines flags
> +#[macro_export]
> +macro_rules! define_flags {
> +    (
> +        $gen_name:ident($gen_type:ident),
> +        $($variant:ident =3D $binding:expr,)+
> +    ) =3D> {
> +        /// Flags that can be combined with the operators `|`, `&`, =
and `!`.
> +        ///
> +        /// Values can be used from the [`flags`] module.
> +        #[derive(Clone, Copy, PartialEq)]
> +        pub struct $gen_name($gen_type);
> +
> +        impl $gen_name {
> +            /// Get the raw representation of this flag.
> +            pub(crate) fn as_raw(self) -> $gen_type {
> +                self.0
> +            }
> +
> +            /// Check whether `flags` is contained in `self`.
> +            pub fn contains(self, flags: $gen_name) -> bool {
> +                (self & flags) =3D=3D flags
> +            }
> +        }
> +
> +        impl core::ops::BitOr for $gen_name {
> +            type Output =3D $gen_name;
> +            fn bitor(self, rhs: Self) -> Self::Output {
> +                Self(self.0 | rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::BitAnd for $gen_name {
> +            type Output =3D $gen_name;
> +            fn bitand(self, rhs: Self) -> Self::Output {
> +                Self(self.0 & rhs.0)
> +            }
> +        }
> +
> +        impl core::ops::Not for $gen_name {
> +            type Output =3D $gen_name;
> +            fn not(self) -> Self::Output {
> +                Self(!self.0)
> +            }
> +        }
> +
> +        #[allow(missing_docs)]
> +        pub mod flags {
> +            use super::$gen_name;
> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: $gen_name =3D $gen_name($binding =
as $gen_type);
> +            )+
> +        }
> +    }
> +}
>=20
> --=20
> 2.43.0
>=20
>=20
>=20

Please drop this patch in favor of the patch from Filipe Xavier. It does =
the same thing.

=E2=80=94 Daniel=
