!Z35184372121601_i64 = !mod_arith.int<35184372121601 : i64>
!Z35184372744193_i64 = !mod_arith.int<35184372744193 : i64>
!Z36028797019389953_i64 = !mod_arith.int<36028797019389953 : i64>
!cc = !openfhe.crypto_context
!params = !openfhe.cc_params
!pk = !openfhe.public_key
!sk = !openfhe.private_key
#inverse_canonical_encoding = #lwe.inverse_canonical_encoding<scaling_factor = 45>
#inverse_canonical_encoding1 = #lwe.inverse_canonical_encoding<scaling_factor = 90>
#key = #lwe.key<>
#modulus_chain_L2_C0 = #lwe.modulus_chain<elements = <36028797019389953 : i64, 35184372121601 : i64, 35184372744193 : i64>, current = 0>
#modulus_chain_L2_C1 = #lwe.modulus_chain<elements = <36028797019389953 : i64, 35184372121601 : i64, 35184372744193 : i64>, current = 1>
#modulus_chain_L2_C2 = #lwe.modulus_chain<elements = <36028797019389953 : i64, 35184372121601 : i64, 35184372744193 : i64>, current = 2>
#ring_f64_1_x8 = #polynomial.ring<coefficientType = f64, polynomialModulus = <1 + x**8>>
!rns_L0 = !rns.rns<!Z36028797019389953_i64>
!rns_L1 = !rns.rns<!Z36028797019389953_i64, !Z35184372121601_i64>
!rns_L2 = !rns.rns<!Z36028797019389953_i64, !Z35184372121601_i64, !Z35184372744193_i64>
!pt = !lwe.new_lwe_plaintext<application_data = <message_type = tensor<8xi16>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>>
!pt1 = !lwe.new_lwe_plaintext<application_data = <message_type = i16>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>>
#ring_rns_L0_1_x8 = #polynomial.ring<coefficientType = !rns_L0, polynomialModulus = <1 + x**8>>
#ring_rns_L1_1_x8 = #polynomial.ring<coefficientType = !rns_L1, polynomialModulus = <1 + x**8>>
#ring_rns_L2_1_x8 = #polynomial.ring<coefficientType = !rns_L2, polynomialModulus = <1 + x**8>>
#ciphertext_space_L0 = #lwe.ciphertext_space<ring = #ring_rns_L0_1_x8, encryption_type = mix>
#ciphertext_space_L1 = #lwe.ciphertext_space<ring = #ring_rns_L1_1_x8, encryption_type = mix>
#ciphertext_space_L2 = #lwe.ciphertext_space<ring = #ring_rns_L2_1_x8, encryption_type = mix>
#ciphertext_space_L2_D3 = #lwe.ciphertext_space<ring = #ring_rns_L2_1_x8, encryption_type = mix, size = 3>
!ct_L0 = !lwe.new_lwe_ciphertext<application_data = <message_type = i16>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>, ciphertext_space = #ciphertext_space_L0, key = #key, modulus_chain = #modulus_chain_L2_C0>
!ct_L1 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xi16>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>, ciphertext_space = #ciphertext_space_L1, key = #key, modulus_chain = #modulus_chain_L2_C1>
!ct_L1_1 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xi16>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding1>, ciphertext_space = #ciphertext_space_L1, key = #key, modulus_chain = #modulus_chain_L2_C1>
!ct_L1_2 = !lwe.new_lwe_ciphertext<application_data = <message_type = i16>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding1>, ciphertext_space = #ciphertext_space_L1, key = #key, modulus_chain = #modulus_chain_L2_C1>
!ct_L2 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xi16>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding>, ciphertext_space = #ciphertext_space_L2, key = #key, modulus_chain = #modulus_chain_L2_C2>
!ct_L2_1 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xi16>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding1>, ciphertext_space = #ciphertext_space_L2, key = #key, modulus_chain = #modulus_chain_L2_C2>
!ct_L2_D3 = !lwe.new_lwe_ciphertext<application_data = <message_type = tensor<8xi16>>, plaintext_space = <ring = #ring_f64_1_x8, encoding = #inverse_canonical_encoding1>, ciphertext_space = #ciphertext_space_L2_D3, key = #key, modulus_chain = #modulus_chain_L2_C2>
module attributes {scheme.ckks} {
  func.func @dot_product(%cc: !cc, %ct: !ct_L2, %ct_0: !ct_L2) -> !ct_L0 {
    %cst = arith.constant dense<[0, 0, 0, 0, 0, 0, 0, 1]> : tensor<8xi64>
    %ct_1 = openfhe.mul_no_relin %cc, %ct, %ct_0 : (!cc, !ct_L2, !ct_L2) -> !ct_L2_D3
    %ct_2 = openfhe.relin %cc, %ct_1 : (!cc, !ct_L2_D3) -> !ct_L2_1
    %ct_3 = openfhe.rot %cc, %ct_2 {index = 4 : index} : (!cc, !ct_L2_1) -> !ct_L2_1
    %ct_4 = openfhe.add %cc, %ct_2, %ct_3 : (!cc, !ct_L2_1, !ct_L2_1) -> !ct_L2_1
    %ct_5 = openfhe.rot %cc, %ct_4 {index = 2 : index} : (!cc, !ct_L2_1) -> !ct_L2_1
    %ct_6 = openfhe.add %cc, %ct_4, %ct_5 : (!cc, !ct_L2_1, !ct_L2_1) -> !ct_L2_1
    %ct_7 = openfhe.rot %cc, %ct_6 {index = 1 : index} : (!cc, !ct_L2_1) -> !ct_L2_1
    %ct_8 = openfhe.add %cc, %ct_6, %ct_7 : (!cc, !ct_L2_1, !ct_L2_1) -> !ct_L2_1
    %ct_9 = openfhe.mod_reduce %cc, %ct_8 : (!cc, !ct_L2_1) -> !ct_L1
    %pt = openfhe.make_ckks_packed_plaintext %cc, %cst : (!cc, tensor<8xi64>) -> !pt
    %ct_10 = openfhe.mul_plain %cc, %ct_9, %pt : (!cc, !ct_L1, !pt) -> !ct_L1_1
    %ct_11 = openfhe.rot %cc, %ct_10 {index = 7 : index} : (!cc, !ct_L1_1) -> !ct_L1_1
    %ct_12 = lwe.reinterpret_application_data %ct_11 : !ct_L1_1 to !ct_L1_2
    %ct_13 = openfhe.mod_reduce %cc, %ct_12 : (!cc, !ct_L1_2) -> !ct_L0
    return %ct_13 : !ct_L0
  }
  func.func @dot_product__encrypt__arg0(%cc: !cc, %arg0: tensor<8xi16>, %pk: !pk) -> !ct_L2 {
    %0 = arith.extsi %arg0 : tensor<8xi16> to tensor<8xi64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %0 : (!cc, tensor<8xi64>) -> !pt
    %ct = openfhe.encrypt %cc, %pt, %pk : (!cc, !pt, !pk) -> !ct_L2
    return %ct : !ct_L2
  }
  func.func @dot_product__encrypt__arg1(%cc: !cc, %arg0: tensor<8xi16>, %pk: !pk) -> !ct_L2 {
    %0 = arith.extsi %arg0 : tensor<8xi16> to tensor<8xi64>
    %pt = openfhe.make_ckks_packed_plaintext %cc, %0 : (!cc, tensor<8xi64>) -> !pt
    %ct = openfhe.encrypt %cc, %pt, %pk : (!cc, !pt, !pk) -> !ct_L2
    return %ct : !ct_L2
  }
  func.func @dot_product__decrypt__result0(%cc: !cc, %ct: !ct_L0, %sk: !sk) -> i16 {
    %pt = openfhe.decrypt %cc, %ct, %sk : (!cc, !ct_L0, !sk) -> !pt1
    %0 = lwe.rlwe_decode %pt {encoding = #inverse_canonical_encoding, ring = #ring_f64_1_x8} : !pt1 -> i16
    return %0 : i16
  }
  func.func @dot_product__generate_crypto_context() -> !cc {
    %params = openfhe.gen_params  {mulDepth = 2 : i64, plainMod = 0 : i64} : () -> !params
    %cc = openfhe.gen_context %params {supportFHE = false} : (!params) -> !cc
    return %cc : !cc
  }
  func.func @dot_product__configure_crypto_context(%cc: !cc, %sk: !sk) -> !cc {
    openfhe.gen_mulkey %cc, %sk : (!cc, !sk) -> ()
    openfhe.gen_rotkey %cc, %sk {indices = array<i64: 1, 2, 4, 7>} : (!cc, !sk) -> ()
    return %cc : !cc
  }
}

