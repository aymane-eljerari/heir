!Z35184372121601_i64 = !mod_arith.int<35184372121601 : i64>
!Z35184372744193_i64 = !mod_arith.int<35184372744193 : i64>
!Z36028797019389953_i64 = !mod_arith.int<36028797019389953 : i64>
!cc = !openfhe.crypto_context
!params = !openfhe.cc_params
!pk = !openfhe.public_key
!sk = !openfhe.private_key
#inverse_canonical_encoding = #lwe.inverse_canonical_encoding<scaling_factor = 0>
#key = #lwe.key<>
#modulus_chain_L2_C2 = #lwe.modulus_chain<elements = <36028797019389953 : i64, 35184372121601 : i64, 35184372744193 : i64>, current = 2>
#ring_f64_1_x8 = #polynomial.ring<coefficientType = f64, polynomialModulus = <1 + x**8>>
!rns_L2 = !rns.rns<!Z36028797019389953_i64, !Z35184372121601_i64, !Z35184372744193_i64>
!pt = !lwe.new_lwe_plaintext<application_data = <message_type = tensor<8xf32>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>>
!pt1 = !lwe.new_lwe_plaintext<application_data = <message_type = f32>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>>
#ring_rns_L2_1_x8 = #polynomial.ring<coefficientType = !rns_L2, polynomialModulus = <1 + x**8>>
#ciphertext_space_L2 = #lwe.ciphertext_space<ring = #ring_rns_L2_1_x8, encryption_type = mix>
#ciphertext_space_L2_D3 = #lwe.ciphertext_space<ring = #ring_rns_L2_1_x8, encryption_type = mix, size = 3>
!ct_L2 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xf32>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>, ciphertext_space = #ciphertext_space_L2, key = #key, modulus_chain = #modulus_chain_L2_C2>
!ct_L2_1 = !lwe.new_lwe_ciphertext<application_data = <message_type = f32>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>, ciphertext_space = #ciphertext_space_L2, key = #key, modulus_chain = #modulus_chain_L2_C2>
!ct_L2_D3 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xf32>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>, ciphertext_space = #ciphertext_space_L2_D3, key = #key, modulus_chain = #modulus_chain_L2_C2>
module attributes {backend.openfhe, scheme.ckks} {
  func.func @dot_product(%cc: !cc, %ct: !ct_L2, %ct_0: !ct_L2) -> !ct_L2_1 {
    %cst = arith.constant dense<[0.000000e+00, 0.000000e+00, 0.000000e+00, 0.000000e+00, 0.000000e+00, 0.000000e+00, 0.000000e+00, 1.000000e+00]> : tensor<8xf64>
    %cst_1 = arith.constant dense<0.10000000149011612> : tensor<8xf64>
    %ct_2 = openfhe.mul_no_relin %cc, %ct, %ct_0 : (!cc, !ct_L2, !ct_L2) -> !ct_L2_D3
    %ct_3 = openfhe.relin %cc, %ct_2 : (!cc, !ct_L2_D3) -> !ct_L2
    %pt = openfhe.make_ckks_packed_plaintext %cc, %cst_1 : (!cc, tensor<8xf64>) -> !pt
    %ct_4 = openfhe.add_plain %cc, %ct_3, %pt : (!cc, !ct_L2, !pt) -> !ct_L2
    %ct_5 = openfhe.rot %cc, %ct_4 {index = 6 : index} : (!cc, !ct_L2) -> !ct_L2
    %ct_6 = openfhe.rot %cc, %ct_3 {index = 7 : index} : (!cc, !ct_L2) -> !ct_L2
    %ct_7 = openfhe.add %cc, %ct_5, %ct_6 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %ct_8 = openfhe.add %cc, %ct_7, %ct_3 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %ct_9 = openfhe.rot %cc, %ct_8 {index = 6 : index} : (!cc, !ct_L2) -> !ct_L2
    %ct_10 = openfhe.add %cc, %ct_9, %ct_6 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %ct_11 = openfhe.add %cc, %ct_10, %ct_3 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %ct_12 = openfhe.rot %cc, %ct_11 {index = 6 : index} : (!cc, !ct_L2) -> !ct_L2
    %ct_13 = openfhe.add %cc, %ct_12, %ct_6 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %ct_14 = openfhe.add %cc, %ct_13, %ct_3 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %ct_15 = openfhe.rot %cc, %ct_14 {index = 7 : index} : (!cc, !ct_L2) -> !ct_L2
    %ct_16 = openfhe.add %cc, %ct_15, %ct_3 : (!cc, !ct_L2, !ct_L2) -> !ct_L2
    %pt_17 = openfhe.make_ckks_packed_plaintext %cc, %cst : (!cc, tensor<8xf64>) -> !pt
    %ct_18 = openfhe.mul_plain %cc, %ct_16, %pt_17 : (!cc, !ct_L2, !pt) -> !ct_L2
    %ct_19 = openfhe.rot %cc, %ct_18 {index = 7 : index} : (!cc, !ct_L2) -> !ct_L2
    %ct_20 = lwe.reinterpret_application_data %ct_19 : !ct_L2 to !ct_L2_1
    return %ct_20 : !ct_L2_1
  }
  func.func @dot_product__encrypt__arg0(%cc: !cc, %arg0: tensor<8xf32>, %pk: !pk) -> !ct_L2 {
    %0 = arith.extf %arg0 : tensor<8xf32> to tensor<8xf64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %0 : (!cc, tensor<8xf64>) -> !pt
    %ct = openfhe.encrypt %cc, %pt, %pk : (!cc, !pt, !pk) -> !ct_L2
    return %ct : !ct_L2
  }
  func.func @dot_product__encrypt__arg1(%cc: !cc, %arg0: tensor<8xf32>, %pk: !pk) -> !ct_L2 {
    %0 = arith.extf %arg0 : tensor<8xf32> to tensor<8xf64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %0 : (!cc, tensor<8xf64>) -> !pt
    %ct = openfhe.encrypt %cc, %pt, %pk : (!cc, !pt, !pk) -> !ct_L2
    return %ct : !ct_L2
  }
  func.func @dot_product__decrypt__result0(%cc: !cc, %ct: !ct_L2_1, %sk: !sk) -> f32 {
    %pt = openfhe.decrypt %cc, %ct, %sk : (!cc, !ct_L2_1, !sk) -> !pt1
    %0 = lwe.rlwe_decode %pt {encoding = #inverse_canonical_encoding, ring = #ring_f64_1_x8} : !pt1 -> f32
    return %0 : f32
  }
  func.func @dot_product__generate_crypto_context() -> !cc {
    %params = openfhe.gen_params  {mulDepth = 2 : i64, plainMod = 0 : i64} : () -> !params
    %cc = openfhe.gen_context %params {supportFHE = false} : (!params) -> !cc
    return %cc : !cc
  }
  func.func @dot_product__configure_crypto_context(%cc: !cc, %sk: !sk) -> !cc {
    openfhe.gen_mulkey %cc, %sk : (!cc, !sk) -> ()
    openfhe.gen_rotkey %cc, %sk {indices = array<i64: 6, 7>} : (!cc, !sk) -> ()
    return %cc : !cc
  }
}

